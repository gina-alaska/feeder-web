class DragonflyCache
  def initialize(app, &block)
    @app = app
    @block = block
  end
  
  def self.endpoint(app, &block)
    self.new(app, &block)
  end
  
  def call(env={})
    dup._call(env)
  end
  
  def _call(env)
    @env = env
    params = Rack::Request.new(env).params.symbolize_keys
    params = params.merge(routing_params(env))
    image = Rails.cache.fetch("/dragonfly-cache/v2/#{params[:id]}/#{params[:size]}/") do
      job = @block.call(params, @app, env)
      { sig: job.signature, mime_type: job.mime_type, data: job.data }
    end
    
    if etag_matches?(image[:sig])
      [304, cache_headers(image), []]
    else
      [200, success_headers(image), [image[:data]] ]
    end
  end
  
  private

  def routing_params(env)
    env['rack.routing_args'] ||
    env['action_dispatch.request.path_parameters'] ||
    env['router.params']
  end
  
  def etag_matches?(signature)
    return @etag_matches unless @etag_matches.nil?
    if_none_match = @env['HTTP_IF_NONE_MATCH']
    @etag_matches = if if_none_match
      if_none_match.tr!('"','')
      if_none_match.split(',').include?(signature) || if_none_match == '*'
    else
      false
    end
  end
  
  def success_headers(image)
    headers = standard_headers(image).merge(cache_headers(image))
    headers.delete_if{|k, v| v.nil? }
  end
  
  def standard_headers(image)
    {
      "Content-Type" => image[:mime_type],
      "Content-Length" => image[:data].size.to_s
    }
  end
  
  def cache_headers(image)
    {
      "Cache-Control" => "public, max-age=31536000", # (1 year)
      "ETag" => %("#{image[:sig]}")
    }
  end
end
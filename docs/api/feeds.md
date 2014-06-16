#Feeds

1. List feeds
2. Show feed
3. List entries
4. Show entry

## List Feeds

```
GET /feeds
```

#### Parameters
| Name | Type | Description |
| ---- |:----:| ----------- |
| online | boolean | Only show feeds that are online, default: false |
| mobile | boolean | Only show feeds that are mobile compatible, default: false |

#### Response
```json
[
  {
    "id": 123456789,
    "title": "Example Feed",
    "slug": "example-feed",
    "description": "Long description of feed",
    "updated_at": "2014-01-01T12:34:01Z",
    "mobile_compatible": true,
    "url": "http://feeder.gina.alaska.edu/feeds/example-feed",
    "online": true,
    "category": "image",
    "preview_url": "http://feeder.gina.alaska.edu/feeds/example-feed/preview.jpg",
    "entries_url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries",
    "more_info_url": "http://feeder.gina.alaska.edu/feeds/example-feed/more_info"
  }
]
```

## Show Feed
```
GET /feeds/:slug
```
#### Response
```json
{
  "id": 123456789,
  "title": "Example Feed",
  "slug": "example-feed",
  "description": "Long description of feed",
  "updated_at": "2014-01-01T12:34:01Z",
  "mobile_compatible": true,
  "url": "http://feeder.gina.alaska.edu/feeds/example-feed",
  "online": true,
  "category": "image",
  "preview_url": "http://feeder.gina.alaska.edu/feeds/example-feed/preview.jpg",
  "entries_url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries",
  "more_info_url": "http://feeder.gina.alaska.edu/feeds/example-feed/more_info"
}
```

## List Entries

```
GET /feeds/:feed/entries
```

#### Parameters

| Name | Type | Description |
| ---- |:----:| ----------- |
| overlay | boolean | Overlay coastline on image, default: false |

#### Response

```json
[
  {
    "id": 12345,
    "name": "example_entry-2014.01.01",
    "slug": "example-entry-2014-01-01",
    "url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries/example-entry-2014-01-01",
    "data_url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries/example-entry-2014-01-01.jpg",
    "preview_url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries/example-entry-2014-01-01/preview.jpg",
    "feed_url": "http://feeder.gina.alaska.edu/feeds/example-feed",
    "starred": false
  }
]
```

## Show Entry

```
GET /feeds/:feed/entries/:entry
```

#### Parameters

| Name | Type | Description |
| ---- |:----:| ----------- |
| overlay | boolean | Overlay coastline on image, default: false |

#### Response

```json
{
  "id": 12345,
  "name": "example_entry-2014.01.01",
  "slug": "example-entry-2014-01-01",
  "url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries/example-entry-2014-01-01",
  "data_url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries/example-entry-2014-01-01.jpg",
  "preview_url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries/example-entry-2014-01-01/preview.jpg",
  "feed_url": "http://feeder.gina.alaska.edu/feeds/example-feed",
  "starred": false
}
```

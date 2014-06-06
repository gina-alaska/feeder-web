#
# Cookbook Name:: feeder-web
# Recipe:: default
#
# Copyright (C) 2014 UAF-GINA
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "feeder-web::database"
include_recipe "feeder-web::application"
include_recipe "feeder-web::unicorn"
include_recipe "feeder-web::nginx"

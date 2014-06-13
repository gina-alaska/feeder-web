# Categories

1. Get a category

## Get a category

```
GET /categories
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
    "id": 123456,
    "name": "Feed Name",
    "slug": "feed-name",
    "feeds": [
      {
        "id": 123456789,
        "title": "Example Feed",
        "slug": "example-feed",
        "description": "Long description of feed",
        "updated_at": "2014-01-01T12:34:01Z",
        "mobile_compatible": true,
        "online": true,
        "category": "image",
        "preview_url": "http://feeder.gina.alaska.edu/feeds/example-feed/preview.jpg",
        "entries_url": "http://feeder.gina.alaska.edu/feeds/example-feed/entries",
        "more_info_url": "http://feeder.gina.alaska.edu/feeds/example-feed/more_info"
      }
    ]
  }
]
```

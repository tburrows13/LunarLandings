local DEFAULT_INTERVAL = 60

local Buckets = {}

function Buckets.new(interval)
  local bucket = { list = {}, interval = interval or DEFAULT_INTERVAL }
  return bucket
end

function Buckets.add(bucket, id, data)
  local bucket_id = id % bucket.interval
  bucket.list[bucket_id] = bucket.list[bucket_id] or {}
  bucket.list[bucket_id][id] = data or {}
end

function Buckets.get(bucket, id)
  if not id then return end
  local bucket_id = id % bucket.interval
  local bucket_data = bucket.list[bucket_id]
  return bucket_data and bucket_data[id]
end

function Buckets.remove(bucket, id)
  if not id then return end
  local bucket_id = id % bucket.interval
  if bucket.list[bucket_id] then
    bucket.list[bucket_id][id] = nil
  end
end

function Buckets.get_bucket(bucket, id)
  local bucket_id = id % bucket.interval
  bucket.list[bucket_id] = bucket.list[bucket_id] or {}
  return bucket.list[bucket_id]
end

function Buckets.reallocate(bucket, new_interval)
  local tmp = {}
  if bucket.interval == new_interval then
    return
  end

  for b_id=0, bucket.interval do
    local bucket_data = bucket.list[b_id]
    for id, data in pairs(d_data or {}) do
      tmp[id] = data
    end
    bucket.list[b_id] = nil
  end

  bucket.interval = new_interval or DEFAULT_INTERVAL
  for id, data in pairs(tmp) do
    Buckets.add(bucket, id, data)
  end
end

function Buckets.migrate(tbl, interval)
  local bucket = Buckets.new(interval)
  for id, data in pairs(tbl) do
    Buckets.add(bucket, id, data)
  end
  return bucket
end

return Buckets

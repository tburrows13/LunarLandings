local DEFAULT_INTERVAL = 60

---@class BucketsLib
local Buckets = {}

---@alias BucketID number
---@alias EntryID any
---@alias EntryValue any

---@alias Bucket<K, V> table<K, V>

---@generic K, V
---@class Buckets<K, V>
---@field list table<BucketID, table>
---@field interval number

---@generic K, V
---@param interval number?
---@return Buckets<K, V>
function Buckets.new(interval)
  local buckets = { list = {}, interval = interval or DEFAULT_INTERVAL }
  return buckets
end

---Add an entry to the buckets object
---@generic K, V
---@param buckets Buckets<K, V>
---@param id EntryID
---@param data EntryValue
function Buckets.add(buckets, id, data)
  local bucket_id = id % buckets.interval
  buckets.list[bucket_id] = buckets.list[bucket_id] or {}
  buckets.list[bucket_id][id] = data or {}
end

--- Retrieve entry given ID
---@generic K, V
---@param buckets Buckets<K, V>
---@param id K
---@return V
function Buckets.get(buckets, id)
  local bucket_id = id % buckets.interval
  local bucket_data = buckets.list[bucket_id]
  return bucket_data[id]
end

--- Retrieve entry using id or `nil` if doesn't exist
---@generic K, V
---@param buckets Buckets<K, V>
---@param id K
---@return V?
function Buckets.get_optional(buckets, id)
  if not id then return end
  local bucket_id = id % buckets.interval
  local bucket_data = buckets.list[bucket_id]
  return bucket_data and bucket_data[id]
end

---@generic K, V
---@param buckets Buckets<K, V>
---@param id K
function Buckets.remove(buckets, id)
  if not id then return end
  local bucket_id = id % buckets.interval
  if buckets.list[bucket_id] then
    buckets.list[bucket_id][id] = nil
  end
end

---@generic K, V
---@param buckets Buckets<K, V>
---@param id K
---@return table<K, V>
function Buckets.get_bucket(buckets, id)
  local bucket_id = id % buckets.interval
  buckets.list[bucket_id] = buckets.list[bucket_id] or {}
  return buckets.list[bucket_id]
end

---@generic K, V
---@param buckets Buckets<K, V>
---@param new_interval number?
function Buckets.reallocate(buckets, new_interval)
  local tmp = {}
  if buckets.interval == new_interval then
    return
  end

  for b_id=0, buckets.interval do
    local bucket_data = buckets.list[b_id]
    for id, data in pairs(bucket_data or {}) do
      tmp[id] = data
    end
    buckets.list[b_id] = nil
  end

  buckets.interval = new_interval or DEFAULT_INTERVAL
  for id, data in pairs(tmp) do
    Buckets.add(buckets, id, data)
  end
end

--- Convert existing `tbl` into a Buckets object
---@generic K, V
---@param tbl table
---@param interval number
---@return Buckets<K, V>
function Buckets.migrate(tbl, interval)
  local buckets = Buckets.new(interval)
  for id, data in pairs(tbl) do
    Buckets.add(buckets, id, data)
  end
  return buckets
end

return Buckets

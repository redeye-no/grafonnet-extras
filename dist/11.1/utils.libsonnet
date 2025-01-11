{

	/**
	 * map2array(map)
	 * Return an array containing entries in map as input
	 *
	 * @param map object in the form of { k : v, k : v ... }
	 *
	 */
	map2array(map = {a:"a",b:"v"}) :: [
		{ k : name, v : map[name] } ,
		for name in (map)
		#for name in std.objectFields(map)
	],
	
	
	map2a(map = {}) ::  std.map(function(key_name) {
	      k: key_name,
	      v: map[key_name],
    }, std.objectFields(map)),
	
	
	m2a(map) :: [
	    k,
    		for k in std.objectFieldsAll(map)
	],
}

/*

local applyModifications(obj, f) =
    obj + {
        [x] : f(obj[x]) for x in std.objectFieldsAll(obj)
    }
;

applyModifications({
    visible: "foo",
    hidden:: "bar",
}, function(x) x + " modified")

--

local join_objects(objs) =
    local aux(arr, i, running) =
        if i >= std.length(arr) then
            running
        else
            aux(arr, i + 1, running + arr[i]) tailstrict;
    aux(objs, 0, {});

{
  foo(x):: {
    [x + i]: {
        data: "x = %s and i = %s" % [x, i],
    } for i in ["1", "2"]
  },

  local items = ["a", "b", "c"],
  joined: join_objects([self.foo(item) for item in items]),
}
>>> Taking a step back, you can also just do this :)

    {
      local items = ["a", "b", "c"],
      joined: {
        [x + i]: {
          data: "x = %s and i = %s" % [x, i],
        } for i in ["1", "2"] for x in items
      }
    }

*/
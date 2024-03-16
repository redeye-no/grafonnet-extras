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

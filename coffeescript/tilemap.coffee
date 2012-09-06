setup_tilemap = (cell_size, size)->
	tile_map = new jaws.TileMap({cell_size: cell_size, size: size})
	viewport = new jaws.Viewport(
		{
			max_x: cell_size[0]*size[0], 
			max_y: cell_size[1]*size[1]
		})

	{tile_map: tile_map,cell_size: cell_size,
	size: size,viewport: viewport}

setup_parallax = (layer_iamges, parallax_options)->

	parallax = new jaws.Parallax(parallax_options)
	
	for l in layer_iamges
		parallax.addLayer( l )

	parallax

framed_tilemap = (width, height, empty_tile_index=0, solid_tile_index=1) ->

	map = ( empty_tile_index for i in [0..width*height] by 1)

	#draw the upper and lower rows
	last_row = (height-1)*width
	for i in [0..width-1] by 1
		map[i] = solid_tile_index
		map[i+last_row] = solid_tile_index

	#draw the first and the last columns
	for i in [1..height-2] by 1
		map[i*width] = solid_tile_index
		map[i*width+width-1] = solid_tile_index

	map

add_random_tiles = (tilemap, width, height,  count, min_index, max_index) ->
	
	range = max_index-min_index
	for i in [0..count-1] by 1
		r = 1+parseInt(Math.random()*(height-2))
		c = 1+parseInt(Math.random()*(width-2))
		tile = min_index + parseInt(Math.random()*range)
		tilemap[r*width+c] = tile
	
	tilemap

setup_game_map = (cell_size, size, indexes, tilesheet)->

	map_info = setup_tilemap(cell_size, size)
	
	width = map_info.size[0]
	height = map_info.size[1]
	tile_width = map_info.cell_size[0]
	tile_height = map_info.cell_size[1]
	blocks = new jaws.SpriteList()
	for c in  [0..width-1] by 1
		for r in [0..height-1] by 1
			
			tile = indexes[r*width+c]
			if tile > 0
				blocks.push( 
					new jaws.Sprite(
						{
						image:"block.png",#tilesheet[tile-1],
						x: c*tile_width,
						y: r*tile_height
						}
					)
				)
	
	map_info.tile_map.push(blocks)
	map_info

class Game

	constructor: ->
		
		@player = new Player(150,150)

		@parallax = setup_parallax(
			[{image: "bg/parallax_1.png", damping: 100},
			{image: "bg/parallax_2.png", damping: 6, y: 15},
			{image: "bg/parallax_3.png", damping: 4, y: 60},
			{image: "bg/parallax_4.png", damping: 2, y: 86}	],
			{repeat_x: true}
		)
		
		img = new jaws.Sprite({image:"block.png"}).image
		tilesheet = new jaws.SpriteSheet({image:img,frame_size: [32,32]})

		map_width = 100
		map_height = 10
		map = framed_tilemap(map_width,map_height,0,1)
		map = add_random_tiles(map, map_width,map_height, 1,1)

		@game_map = setup_game_map(
				[32,32], [map_width,map_height],
				map,
				tilesheet.frames)

		jaws.preventDefaultKeys(["up","down","left","right"])

	update: ->
		@player.sprite.setImage( @player.sprite.anim_default.next() )

		@player.vx = 0

		if jaws.pressed("left")
			@player.sprite.flipped = true
			@player.vx = -2
			@player.sprite.setImage( @player.sprite.anim_left.next())
		if jaws.pressed("right")
			@player.sprite.flipped = false
			@player.vx = 2
			@player.sprite.setImage( @player.sprite.anim_right.next())
		if jaws.pressed("up") and @player.can_jump
			@player.vy = -10
			@player.can_jump = false

		@player.vy += 0.4
		@player.move(@game_map.tile_map)
		
		@game_map.viewport.centerAround(@player.sprite)
		@parallax.camera_x = @game_map.viewport.x
		@parallax.camera_y = -@game_map.viewport.y
	
	draw: ->
		jaws.clear()
		@parallax.draw()
		v = @game_map.viewport
		v.drawTileMap @game_map.tile_map
		v.draw @player.sprite

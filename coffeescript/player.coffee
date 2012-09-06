class Player

	constructor: (x,y)->
		@sprite = new jaws.Sprite({x: x, y: y,scale: 1,anchor: "center_bottom"})
		anim = new jaws.Animation({
			sprite_sheet: "sprites/hero.png",
			frame_size: [41,70], frame_duration: 100})

		@sprite.anim_default = anim.slice(3,4)
		@sprite.anim_left = anim.slice(0,2)
		@sprite.anim_right = anim.slice(0,2)

		@sprite.setImage( @sprite.anim_default.next() )
		@vx=0
		@vy=0

	move: (tile_map) ->
		@sprite.x += @vx
		if tile_map.atRect(@sprite.rect()).length > 0
			@sprite.x -= @vx

		@vx = 0

		@sprite.y += @vy

		block = tile_map.atRect(@sprite.rect())[0]

		if block
			if @vy > 0
				@can_jump = true
				@sprite.y = block.rect().y - 1
			else if @vy < 0
				@sprite.y = block.rect().bottom +
					@sprite.height

			@vy = 0

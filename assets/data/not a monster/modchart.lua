-- this gets called starts when the level loads.
function start(song) -- arguments, the song name

end

-- this gets called every frame
function update (elapsed)
	for i=0,7 do
		setActorAngle(getActorAngle(i) + 15, i)
	end
end


-- this gets called every beat
function beatHit(beat) -- arguments, the current beat of the song

end

-- this gets called every step
function stepHit(step) -- arguments, the current step of the song (4 steps are in a beat)

end


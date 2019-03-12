#!/bin/sh

_=[[
	[ -d results ] || mkdir results
	for beha in "meta" "native"; do
		echo "# ------------------------------------- # $beha #"
		for lua in lua5.1 lua5.2 lua5.3 luajit-2.0 luajit-2.1; do
			if ! command -v "$lua" >/dev/null 2>&-; then
				continue
			fi
			d="results/${beha}"
			[ -d "$d" ] || mkdir -- "$d"
			echo ""
			echo "# run: $lua $0 $beha $*"
			"$lua" "$0" "$beha" "$@" | tee "$d/$lua.txt"
		done
	done
	exit
]]

local function stat(a)
	print( ("%0.3f MiB"):format(collectgarbage("count")/1024), a and a or "")
end

stat("enter in the block")
local meta = require "meta"
stat("after require'meta'")

local getmetatable, setmetatable = getmetatable, setmetatable
if arg[1] == "meta" then
	getmetatable, setmetatable = meta.getmetatable, meta.setmetatable
end

if _VERSION=="Lua 5.2" then
	collectgarbage("generational")
end

	local B = {}
	stat()
	local total = assert( tonumber(arg[2]) or 100000 )
	for i=1,total do
		B[i] = setmetatable({"b"..i}, { __test=("x"):rep(1024) })
	end

for I=1,3 do

	local A = {}
	stat()
	local total = assert( tonumber(arg[2]) or 100000 )
	for i=1,total do
		A[i] = setmetatable({I..i}, { __test=("x"):rep(1024) })
	end

	local x = tostring(assert(getmetatable(A[1])))
	collectgarbage() collectgarbage()
	assert(x==tostring(getmetatable(A[1])))

	A=nil

	stat("drop A, no more reference (before collect)")
	collectgarbage() collectgarbage()
	stat("after dual-collect")
end

B=nil


stat("drop A|B, no more reference (before collect)")
collectgarbage() collectgarbage()
stat("<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)")

collectgarbage() collectgarbage()
stat("before purge")
meta.purge()
print("purged")

stat("before collect")
collectgarbage() collectgarbage()
stat("after collect; inside the block")

collectgarbage() collectgarbage()
stat("outside of the block")
-- require"package".loaded.meta = nil
-- stat("unload meta module")


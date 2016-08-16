Custom implementation (with weak table)
=======================================


```
# run: lua5.1 ./test.meta.lua meta
0.032788276672363MB	enter in the block
0.036608695983887MB	after require'meta'
0.036751747131348MB
23.054023742676MB	drop A, no more reference (before collect)
5.0311756134033MB	<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)
5.0311756134033MB	before purge
internal table reset
purged
0.03117561340332MB	before collect
0.03117561340332MB	after collect; inside the block
0.031136512756348MB	outside of the block

# run: lua5.2 ./test.meta.lua meta
0.028696060180664MB	enter in the block
0.036984443664551MB	after require'meta'
0.037127494812012MB
123.08927345276MB	drop A, no more reference (before collect)
5.0269594192505MB	<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)
5.0269594192505MB	before purge
internal table reset
purged
0.027035713195801MB	before collect
0.026959419250488MB	after collect; inside the block
0.026813507080078MB	outside of the block

# run: lua5.3 ./test.meta.lua meta
0.028117179870605MB	enter in the block
0.035520553588867MB	after require'meta'
0.035655975341797MB
119.80342388153MB	drop A, no more reference (before collect)
4.029935836792MB	<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)
4.029935836792MB	before purge
internal table reset
purged
0.030004501342773MB	before collect
0.029935836791992MB	after collect; inside the block
0.029805183410645MB	outside of the block

# run: luajit-2.0 ./test.meta.lua meta
0.030488014221191MB	enter in the block
0.034048080444336MB	after require'meta'
0.034145355224609MB
14.712344169617MB	drop A, no more reference (before collect)
3.0301609039307MB	<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)
3.0301609039307MB	before purge
internal table reset
purged
0.030160903930664MB	before collect
0.030160903930664MB	after collect; inside the block
0.030128479003906MB	outside of the block
```

standard implementation
=======================

```
# run: lua5.1 ./test.meta.lua native
0.032817840576172MB	enter in the block
0.036638259887695MB	after require'meta'
0.036781311035156MB
18.054087638855MB	drop A, no more reference (before collect)
0.031205177307129MB	<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)
0.031205177307129MB	before purge
internal table reset
purged
0.031205177307129MB	before collect
0.031205177307129MB	after collect; inside the block
0.031166076660156MB	outside of the block

# run: lua5.2 ./test.meta.lua native
0.028725624084473MB	enter in the block
0.037014007568359MB	after require'meta'
0.03715705871582MB
118.08933544159MB	drop A, no more reference (before collect)
0.02698802947998MB	<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)
0.02698802947998MB	before purge
internal table reset
purged
0.027064323425293MB	before collect
0.02698802947998MB	after collect; inside the block
0.026843070983887MB	outside of the block

# run: lua5.3 ./test.meta.lua native
0.028665542602539MB	enter in the block
0.035428047180176MB	after require'meta'
0.035563468933105MB
115.80348777771MB	drop A, no more reference (before collect)
0.029965400695801MB	<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)
0.029965400695801MB	before purge
internal table reset
purged
0.030034065246582MB	before collect
0.029965400695801MB	after collect; inside the block
0.029834747314453MB	outside of the block

# run: luajit-2.0 ./test.meta.lua native
0.030509948730469MB	enter in the block
0.034070014953613MB	after require'meta'
0.034167289733887MB
11.712366104126MB	drop A, no more reference (before collect)
0.030182838439941MB	<--- after dual-collect (at this step the weak table is empty, memory should be returned to a normal level)
0.030182838439941MB	before purge
internal table reset
purged
0.030182838439941MB	before collect
0.030182838439941MB	after collect; inside the block
0.030150413513184MB	outside of the block
```

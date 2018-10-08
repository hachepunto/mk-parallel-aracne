<config.mk
PWD=`pwd`

results/%.genes.txt:	data/%.txt
	set -x
	mkdir -p `dirname $target`
	awk -F "\t" '{print $1 ".target"}' $prereq \
	| tail -n +2 \
	> $target

'results/(.+)/(.+)\.target':R:	'results\/\1\.genes\.txt'
	set -x
	mkdir -p `dirname $target`
	cd "results/"$stem1"/"
	cat "../../"$prereq \
	| xargs touch

'results/(.+)/(.+)\.adj':R:	'results\/\1\/\2\.target'
	set -x
	mkdir -p `dirname $target`
	aracne -i "data/"$stem1".txt" \
		-h $stem2 \
		-p 1 \
		-o $target".build" \
	&& rm "./results/"$stem1"/"$stem2".target" \
	&& mv $target".build" $target

# 'results/(.+)\.adj':R:	'results\/\1\/(.+)\.adj'
# 	set -x
# 	mkdir -p `dirname $target`
# 	ls "results/"$stem1"/*adj" \
# 	| xargs tail -n 1 \
# 	> $target".build" \
# 	&& mv $target".build" $target

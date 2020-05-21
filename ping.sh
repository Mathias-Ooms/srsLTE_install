for SIZE in 56 92 192 392 792 1192 1492
do
	ping -c 10 -s $SIZE -q 192.168.0.100
done

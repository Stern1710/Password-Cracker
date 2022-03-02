all: crack

clean:
	rm -f crack
	rm -f *.o

crack: crack.c
	gcc -o crack -g -ansi -Wall -Wextra -pedantic -Wmissing-prototypes -Wstrict-prototypes -Wold-style-definition crack.c -lcrypto

generate: crack
	./crack -c michael1 12345 SHA1
	./crack -c michael2 12345 SHA2 1234567890ABCDEF
	./crack -c verena3 passw SHA2 1234567890fedcba
	./crack -c heinrich4 letme SHA1
	./crack -c michael5 1 SHA1 1234567890ABCDEF
	./crack -c michael6 B SHA2
	./crack -c michael7 12 SHA1
	./crack -c michael8 AB SHA2
	./crack -c michael9 bc SHA2

testgenerate: crack
	valgrind --leak-check=full --track-fds=yes --show-reachable=yes ./crack -c michael1 12345 SHA1
	valgrind --leak-check=full --track-fds=yes --show-reachable=yes ./crack -c michael2 12345 SHA2 1234567890ABCDEF

test: crack
	valgrind --leak-check=full --track-fds=yes --show-reachable=yes ./crack -b hashes.txt 1 2

testraw: crack
	./crack -b -t hashes.txt 1 3

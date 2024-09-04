The experiment data is organized as follows:

Individual pariticipant responses are collected in .csv files named Corrected_???.mat, where ??? is the three letter observer ID assigned during the experiment. 
The files contain a matrix that is 6x22. Each row contains data for a different display pair. These pairs are, by row numbers:

1 - (Display) 1 and (Display) 2
2 - 1 and 3
3 - 1 and 4
4 - 2 and 3
5 - 2 and 4
6 - 3 and 4

Display numbers are:
1: LG C2 (OLED TV)
2: Sony X310 (Reference Monitor)
3: Samsung LSP9T (Laser Projector)
4: ASUS VG246 (Gaming Monitor)

Each column contains data for a specific color. The colors are presented in the same order as in the paper. Colors 2 and 5 are not evaluated on display
4 because they are outside of the gamut.
The first 11 columns contain the data from the first half of the experiment, where observers evaluated all colors on all display pairs once. Columns 12 to 22 contain
data from the second half of the experiment, where each evaluation was repeated. The evaluations match positions in both matrix halves, i.e. position (1,1) contains the
answer to the first evaluation of color 1 on displays 1 and 2, position (1,12) contains the second evaluation of the same color on the same displays.

ObserverData contains the birth sex and age information of the observers who participated in the experiment. 
To preserve the anonymity of our observers, all observer information is pooled.
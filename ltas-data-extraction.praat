#	This script creates Ltas for all the files in a folder and saves the Ltas data in independent txt files
#	The name of the files will be the same as the wav sound file.
#
#	Script under a GNU General Public License contract. 
#	wendyelviragarcia @ g m a i l . c o m
#	Laboratori de Fonètica (Universitat de Barcelona)
#	Citation: Elvira García, Wendy (2015). Ltas data. Praat script. (Retrieved from http://stel.ub.edu/labfon/en)
###################################################################################



folder$ = chooseDirectory$ ("Folder")

#	BUCLE	##########################
strings = Create Strings as file list: "list", folder$ + "/" + "*.wav"
numberOfFiles = Get number of strings
do_not_warn_me_again = 0
for nfile to numberOfFiles
	selectObject: "Strings list"
	fileName$ = Get string: nfile
	base$= fileName$ - ".wav"
	output$ = folder$ + "/" +  base$ + ".txt"
	
	
	while do_not_warn_me_again = 0 and fileReadable (output$)
		
			beginPause: "Existing file"
				comment: "There is already a file with that name, you will overwrite it"
				boolean: "Do_not_warn_me_again", 0
			endPause: "Continue", 1
			deleteFile: output$
		
	endwhile
	
		
	#CORE
	sound = Read from file: folder$ + "/" + base$ + ".wav"
	ltas = To Ltas (pitch-corrected): 75, 600, 8000, 100, 0.0001, 0.02, 1.3
	matrix= To Matrix
	numberOfRows = Get number of rows
	numberOfColumns = Get number of columns

	for row to numberOfRows
		for column to numberOfColumns
			value = Get value in cell: row, column
			appendFile: output$, value, tab$	
		endfor
		appendFile: output$, newline$
	endfor
	removeObject: sound, ltas, matrix
endfor
removeObject: strings
writeInfoLine: "Done. Ltas information is in " + folder$
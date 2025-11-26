function protect() {                     
    # Get the current date in YY_MM_DD format
    timestamp=$(date +%y_%m_%d)
	file=$1
    
    # Create a compressed tarball of the specified directory
    tar -czf ${file}_${timestamp}.tgz $file
    
    # Encrypt the tarball using GPG and rename the output file
    gpg -c ${file}_${timestamp}.tgz

	rm ${file}_${timestamp}.tgz
    
}                                              
export -f protect

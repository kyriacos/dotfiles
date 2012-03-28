# ls command
* ls -t = last modified
* vim `ls -t | head -1` = opens last edited file
* ls -1 = one file per line
* ls -l = all information about files/directories
  Field Explanation
  - normal file
  - d directory
  - s socket file
  - l link file
  1. Field 1 – File Permissions: Next 9 character specifies the files permission. Each 3 characters refers to the read, write, execute permissions for user, group and world In this example, -rw-r—– indicates read-write permission for user, read permission for group, and no permission for others.
  2. Field 2 – Number of links: Second field specifies the number of links for that file. In this example, 1 indicates only one link to this file.
  3. Field 3 – Owner: Third field specifies owner of the file. In this example, this file is owned by username ‘ramesh’.
  4. Field 4 – Group: Fourth field specifies the group of the file. In this example, this file belongs to ”team-dev’ group.
  5. Field 5 – Size: Fifth field specifies the size of file. In this example, ’9275204′ indicates the file size.
  6. Field 6 – Last modified date & time: Sixth field specifies the date and time of the last modification of the file. In this example, ‘Jun 13 15:27′ specifies the last modification time of the file.
  7. Field 7 – File name: The last field is the name of the file. In this example, the file name is mthesaur.txt.gz.
* ls -ld /etc = directory information
* ls -F = visual classification of files (add --color=auto for colors)
  - /       = directory
  - nothing = normal file
  - @       = link file
  - *       = executable file

# netstat
* -a  = list all ports
* -at = list all tcp ports
* -au = list all udp ports
* -l  = list only listening post
* -lt = same for tcp
* -lu = same for udp
* -lx = unix ports
* -s = show statistics for all ports
* -st = same for tcp
* -su = same for udp
* -p = display PID and program name (helps identify which program is runnning on a particular port)
* -an = dont resolve host port and username
* -c = display continuously
* --verbose = non supportive Address families in your system
* -r = show kernel routing information
* -ap | grep ssh = find out which port a program is running
* -an | grep ':80' = which process if using a particular port
* -i = show the list of network interfaces
* -ie = display extended information on the interfaces similar to ifconfig

# wget
* -O name.zip url = output file name
* --limit-rate=200k url = limit download rate
* -c url = continue incomplete download
* -b url = download in background (check status by `tail -f wget-log`)
* --user-agent="Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3" url
* --spider url = test url
* -i download-list.txt = download multiple files (seperated with newline)
* --mirror -p --convert-links -P ./local-dir http://url =
        - mirror
        - p : all files necessary to display html page
        - convert-links : for local viewing
        - P ./local-dir : save all files in this dir
* --reject=gif url = reject certain file types
* -r -A.pdf url = download only certain files
* --ftp-user=USER --ftp-password=PASS ftp-url = or nothing for anonymous

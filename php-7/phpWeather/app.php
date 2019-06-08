<?php 
$file = 'var/www/site/demo.txt'
if (file_exists($file)) {
	echo file_get_contents($file);
	}

<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$con = mysqli_connect("sql103.infinityfree.com", "if0_38074341", "aYXrQ15rprAYl", "if0_38074341_company");
// Check connection
if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$sql = "select books.book_id, books.title, books.genre, books.stock, books.price, authors.author author
from books
INNER JOIN authors on books.author_id = authors.id";
if ($result = mysqli_query($con, $sql)) {
    $emparray = array();
    while ($row = mysqli_fetch_assoc($result))
        $emparray[] = $row;

    echo (json_encode($emparray));
    // Free result set
    mysqli_free_result($result);
    mysqli_close($con);
}

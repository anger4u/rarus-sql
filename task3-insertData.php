<?php

$host = 'localhost'; // имя хоста (уточняется у провайдера)
$database = 'RARUS_SQL'; // имя базы данных, которую вы должны создать
$user = 'root'; // заданное вами имя пользователя, либо определенное провайдером
$pswd = ''; // заданный вами пароль

$dbh = mysqli_connect($host, $user, $pswd) or die("Не могу соединиться с MySQL. ");
mysqli_select_db($dbh, $database) or die("Не могу подключиться к базе. ");


function randName($arr)
{
    return $arr[random_int(1, count($arr)-1)];
}

function randLogin($arr)
{
    return $arr[random_int(1, count($arr)-1)];
}

function randPhone()
{
    return '8978' . random_int(0000000, 9999999);
}


// INSERT DATA

function fillBase($dbh)
{
    $names = ['Илья Иванов', 'Саша Покалов', 'Маша Иванова', 'Юля Исаева', 'Петя Коглонов', 'Сёма Степанов', 'Витя Троицкий',
        'Миша Лихонов', 'Гриша Аврамов', 'Атиша Украева', 'Олег Олегов', 'Ксюша Сигонова'];
    $logins = ['arrayas', 'link', 'olopa', 'qwerty', 'qwerty123', 'polopo', 'asdfgh', 'kop', 'lasa', 'loper', 'homie',
        'joe', 'tyser', 'holly', 'kia', 'motors', 'kopper', 'fieldas', 'jusmine'];
    $groups = ['Работа', 'Друзья', 'Семья', 'Школа', 'Часто используемые'];
    $channels = ['email', 'WhatsApp', 'Viber', 'Telegram'];
    $userCount = 10;
    $userContacts = 10;

    // insert юзеров в базу
    for ($i = 1; $i <= $userCount; $i++) {
        $userName = randName($names);
        $userLogin = randLogin($logins);
        $addUser = <<<SQL
          INSERT INTO users(id, name, login) VALUES ($i, '$userName', '$userLogin');
SQL;
        mysqli_query($dbh, $addUser);

        // insert групп каждому юзеру
        foreach($groups as $group) {
            $addGroup = <<<SQL
            INSERT INTO groups(user_id, name) VALUES ($i, '$group');
SQL;
            mysqli_query($dbh, $addGroup);
        }

        // insert контактов каждому юзеру
        for($y = 1; $y <= $userContacts; $y++ ) {
            $contName = randName($names);
            $contPhone = randPhone();
            $contMail = randLogin($logins) . '-mail@google.com';
            $groupId = random_int(1, count($groups));
            $addCont = <<<SQL
              INSERT INTO contacts(user_id, name, phone, email) VALUES ($y, '$contName', '$contPhone', '$contMail');
SQL;

            mysqli_query($dbh, $addCont);

            $addGroupCont = <<<SQL
              INSERT INTO contacts_groups(contact_id, group_id) VALUES ($y, $groupId);
SQL;

            mysqli_query($dbh, $addGroupCont);
        }
    }

    foreach($channels as $channel) {
        $addChannel = <<<SQL
      INSERT INTO channels(name) VALUES ('$channel');
SQL;
        mysqli_query($dbh, $addChannel);
    }

}

fillBase($dbh);
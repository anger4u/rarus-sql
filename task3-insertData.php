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

            // insert контактов каждому юзеру
            for($y = 0; $y < $userContacts; $y++ ) {
                $contName = randName($names);
                $contPhone = randPhone();
                $contMail = randLogin($logins) . '-mail@google.com';
                $addCont = <<<SQL
                  INSERT INTO contacts(user_id, name, phone, email) VALUES ($i, '$contName', '$contPhone', '$contMail');
SQL;
                mysqli_query($dbh, $addCont);

            // insert групп каждому юзеру
            for($z = 1; $z <= 5; $z++) {
                $addGroup = <<<SQL
                INSERT INTO users_groups(user_id, group_id) VALUES ($i, $z);
SQL;
                mysqli_query($dbh, $addGroup);
            }
        }

        // insert групп в базу
        foreach($groups as $group) {
            $addGroup = <<<SQL
          INSERT INTO groups(name) VALUES ('$group');
SQL;
            mysqli_query($dbh, $addGroup);
        }

        // insert каналов в базу
        foreach($channels as $channel) {
            $addChannel = <<<SQL
          INSERT INTO channels(name) VALUES ('$channel');
SQL;
            mysqli_query($dbh, $addChannel);
        }
    }

    // insert контактов с группами
    for($h = 1; $h <= ($userCount * $userContacts); $h++) {
        $groupInd = mt_rand(1, count($groups));
        $addGroupCont = <<<SQL
          INSERT INTO contacts_groups(contact_id, group_id) VALUES ($h, $groupInd);
SQL;
        mysqli_query($dbh, $addGroupCont);
    }
}

fillBase($dbh);
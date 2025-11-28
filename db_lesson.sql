
Q1
CREATE TABLE `departments`(
  `department_id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(20) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

Q2
ALTER TABLE people ADD department_id INT UNSIGNED AFTER email;

Q3
INSERT INTO departments (name)
  VALUES
  ('営業'),
  ('開発'),
  ('経理'),
  ('人事'),
  ('情報システム');

INSERT INTO people(name,email,age,gender,department_id)
  VALUES
  ('石田はな','hana@beyond-works.co.jp','33','2','1'),
  ('原田あおい','aoi@beyond-works.co.jp','29','1','1'),
  ('鈴木ひろ','hiro@beyond-works.co.jp','30','1','1'),
  ('白石ゆり','yuri@beyond-works.co.jp','25','2','2'),
  ('斎藤かい','kai@beyond-works.co.jp','40','1','2'),
  ('山田くみ','kumi@beyond-works.co.jp','33','2','2'),
  ('山田たろう','tarou@beyond-works.co.jp','49','1','2'),
  ('高橋みさ','misa@beyond-works.co.jp','26','2','3'),
  ('林はる','haru@beyond-works.co.jp','39','2','4'),
  ('清水あき','aki@beyond-works.co.jp','28','1','5');

INSERT INTO reports(person_id,content)
  VALUES
  ('62','本日は、契約をしました。'),
  ('63','本日は、契約につながるプレゼンができました。'),
  ('64','本日は、外部研修を受けました。'),
  ('65','本日は、開発に関する勉強をしました。'),
  ('66','本日は、新しい業務を引き継ぎました。'),
  ('67','本日は、課題が難しく全然進みませんでした。'),
  ('68','本日は、新開発に向けた会議がありました。'),
  ('69','本日は、数字と向き合いました。'),
  ('70','本日は、面接対応をしました。'),
  ('71','本日は、新人教育をしました。');


SELECT * FROM people WHERE department_id IS NULL;

Q4
UPDATE people
SET department_id = ELT(FIELD(person_id,1,2,3,4,6,7,8,9,10,11),1,3,2,4,5,2,4,3,5,1)
WHERE person_id IN (1,2,3,4,6,7,8,9,10,11);

Q5
SELECT * FROM people WHERE gender = 1 ORDER BY age DESC;

Q6
SELECT
  `name`, `email`, `age`   --  カラム名を指定して３つのカラムを取得
FROM
  `people`    --  テーブル名peopleからSELCTで指定した３つのカラムを取得する
WHERE
  `department_id` = 1   --  部署IDが1番の特定のレコード
ORDER BY    --  昇順で並び替え
  `created_at`;   --  レコードが作成された日時

  peopleテーブルから指定した部署のnameとemailとageのカラムを、レコードが作成された日時の順番（昇順）で取得する。

Q7
SELECT name,age FROM people WHERE age BETWEEN 40 AND 49 AND gender = 1 UNION ALL SELECT name,age FROM people
WHERE age BETWEEN 20 AND 29 AND gender = 2;

Q8
SELECT name,age,department_id FROM people WHERE department_id = 1 ORDER BY age ASC;

Q9
SELECT AVG(age) AS average_age FROM people WHERE gender = 2 AND department_id = 2;

Q10
SELECT p.name AS person_name,d.name AS department_name,r.content AS content
  FROM people AS p JOIN reports AS r ON p.person_id = r.person_id LEFT JOIN departments AS d ON p.department_id = d.department_id
  WHERE r.content IS NOT NULL AND r.content <> '';


Q11
SELECT p.name FROM people AS p LEFT JOIN reports AS r ON p.person_id = r.person_id
  WHERE r.person_id IS NULL OR r.content = '';


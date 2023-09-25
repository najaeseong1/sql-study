SELECT * FROM info;
SELECT * FROM auth;

-- ÀÌ³Ê(³»ºÎ) Á¶ÀÎ

SELECT
    *
FROM info i
INNER JOIN auth a
ON i.auth_id = a.auth_id;

-- ¿À¶óÅ¬ ¹®¹ı (Àß »ç¿ë ¾ÈÇÕ´Ï´Ù.)
SELECT
    *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;

-- auth_id ÄÃ·³À» ±×³É ¾²¸é ¸ğÈ£ÇÏ´Ù ¶ó°í ¶å´Ï´Ù.
-- ±× ÀÌÀ¯´Â ¾çÂÊ Å×ÀÌºí¿¡ ¸ğµÎ Á¸ÀçÇÏ±â ¶§¹®ÀÔ´Ï´Ù.
-- ÀÌ·² ¶§´Â, ÄÃ·³¿¡ Å×ÀÌºí ÀÌ¸§À» ºÙÀÌ´øÁö, º°ÄªÀ» ¾²¼Å¼­
-- È®½ÇÇÏ°Ô Áö¸ñÀ» ÇØÁÖ¼¼¿ä.
SELECT
    auth.auth_id, title, content, name
FROM info
INNER JOIN auth -- JOIN ÀÌ¶ó°í¸¸ ¾²¸é ±âº»ÀûÀ¸·Î INNER JOIN ½ÇÇà
ON info.auth_id = auth.auth_id;

-- ÇÊ¿äÇÑ µ¥ÀÌÅÍ¸¸ Á¶È¸ÇÏ°Ú´Ù! ¶ó°í ÇÑ´Ù¸é
-- WHERE ±¸¹®À» ÅëÇØ ÀÏ¹İ Á¶°ÇÀ» °É¾î ÁÖ¸é µÈ´Ù.
SELECT
    a.auth_id, title, content, name
FROM info i
JOIN auth a
ON i.auth_id = a.auth_id
WHERE a.name = 'ÀÌ¼ø½Å';

-- ¾Æ¿ìÅÍ (¿ÜºÎ) Á¶ÀÎ
SELECT
    *
FROM info i LEFT JOIN auth a -- OUTTER »ı·« °¡´É
ON i.auth_id = a.auth_id;

-- ¾Æ¿ìÅÍ (¿ÜºÎ) Á¶ÀÎ, ¿À¶óÅ¬ ¹®¹ı
SELECT
    *
FROM info i, auth a
WHERE i.auth_id = a.auth_id(+);

-- ÁÂÃø Å×ÀÌºí°ú ¿ìÃø Å×ÀÌºí µ¥ÀÌÅÍ¸¦ ¸ğµÎ ÀĞ¾î Áßº¹µÈ µ¥ÀÌÅÍ´Â »èÁ¦µÇ´Â ¿ÜºÎ Á¶ÀÎ
SELECT
    *
FROM info i FULL JOIN auth a ON i.auth_id = a.auth_id;

-- CROSS JOINÀº JOINÁ¶°ÇÀ» ¼³Á¤ÇÏÁö ¾Ê±â ¶§¹®¿¡
-- ´Ü¼øÈ÷ ¸ğµç Ä¿·³¿¡ ´ëÇØ JOinÀ» ÁøÇàÇÕ´Ï´Ù.
-- ½ÇÁ¦·Î´Â °ÅÀÇ »ç¿ëÇÏÁö ¾Ê½À´Ï´Ù.
SELECT * FROM info
CROSS JOIN auth
ORDER BY id ASC;

-- ¿©·¯ °³ Å×ÀÌºí Á¶ÀÎ -> Å° °ªÀ» ­‡¾Æ¼­ ±¸¹®À» ¿¬°áÇØ¼­ ¾²¸é µË´Ï´Ù.
SELECT
    *
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN locations loc ON d.location_id = loc.location_id;

/*
- Å×ÀÌºí º°Äª a, i¸¦ ÀÌ¿ëÇÏ¿© LEFT OUTER JOIN »ç¿ë.
- info, auth Å×ÀÌºí »ç¿ë
- job ÄÃ·³ÀÌ scientistÀÎ »ç¶÷ÀÇ id, title, content, jobÀ» Ãâ·Â.
*/
SELECT
    i.auth_id,i.title,i.content,a.job
FROM auth a LEFT JOIN info i
ON i.auth_id = a.auth_id
WHERE a.job = 'scientist';

-- ¼¿ÇÁ Á¶ÀÎÀÌ¶õ µ¿ÀÏ Å×ÀÌºí »çÀÌÀÇ Á¶ÀÎÀ» ¸»ÇÕ´Ï´Ù.
-- µ¿ÀÏ Å×ÀÌºí ÄÃ·³À» ÅëÇØ ±âÁ¸¿¡ Á¸ÀçÇÏ´Â °ªÀ» ¸ÅÄªší °¡Á®¿Ã ¶§ »ç¿ëÇÕ´Ï´Ù.

SELECT
    e1.employee_id, e1,first_name, e1.manager_id,
    e2.first_name, e2.employee_id
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.employee_id;

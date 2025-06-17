ALTER TABLE Scooters COMMENT = 'Інформація про електросамокати';

ALTER TABLE Scooters MODIFY COLUMN scooter_id INT AUTO_INCREMENT COMMENT 'Унікальний ідентифікатор самоката';
ALTER TABLE Scooters MODIFY COLUMN model_id INT COMMENT 'Зовнішній ключ до технічних характеристик';
ALTER TABLE Scooters MODIFY COLUMN scooter_geolocation POINT NOT NULL COMMENT 'Координати місцеположення самоката';
ALTER TABLE Scooters MODIFY COLUMN charge_status INT NOT NULL COMMENT 'Рівень заряду (%)';
ALTER TABLE Scooters MODIFY COLUMN kilometers_left DECIMAL(7,2) NOT NULL COMMENT 'Залишок км';
ALTER TABLE Scooters MODIFY COLUMN is_active BOOLEAN DEFAULT TRUE COMMENT 'Активність самоката';
ALTER TABLE Scooters MODIFY COLUMN last_maintenance DATETIME COMMENT 'Дата останнього технічного обслуговування';

ALTER TABLE Pricing COMMENT = 'Цінові плани для поїздок';

ALTER TABLE Pricing MODIFY COLUMN pricing_id INT AUTO_INCREMENT COMMENT 'Ідентифікатор тарифного плану';
ALTER TABLE Pricing MODIFY COLUMN price_per_minute DECIMAL(5,2) COMMENT 'Ціна за хвилину';
ALTER TABLE Pricing MODIFY COLUMN unlock_fee DECIMAL(5,2) COMMENT 'Плата за розблокування';
ALTER TABLE Pricing MODIFY COLUMN is_active BOOLEAN DEFAULT TRUE COMMENT 'Чи активний тариф';

ALTER TABLE Tickets COMMENT = 'Скарги або повідомлення про проблеми';

ALTER TABLE Tickets MODIFY COLUMN ticket_id INT AUTO_INCREMENT COMMENT 'Ідентифікатор тікета';
ALTER TABLE Tickets MODIFY COLUMN user_id INT COMMENT 'ID користувача, який подав тікет';
ALTER TABLE Tickets MODIFY COLUMN ticket_status VARCHAR(50) COMMENT 'Статус тікета (новий, в обробці, закритий)';
ALTER TABLE Tickets MODIFY COLUMN ticket_description TEXT COMMENT 'Опис проблеми або скарги';

ALTER TABLE Balances COMMENT = 'Баланс користувача у грошах та доступних км';

ALTER TABLE Balances MODIFY COLUMN balance_id INT AUTO_INCREMENT COMMENT 'Ідентифікатор балансу';
ALTER TABLE Balances MODIFY COLUMN user_id INT COMMENT 'ID користувача';
ALTER TABLE Balances MODIFY COLUMN current_balance DECIMAL(8,2) DEFAULT 0.00 COMMENT 'Поточний баланс користувача';
ALTER TABLE Balances MODIFY COLUMN kilometres_available DECIMAL(6,2) COMMENT 'Доступні кілометри за підпискою або бонусами';

ALTER TABLE Subscriptions COMMENT = 'Доступні типи підписок';

ALTER TABLE Subscriptions MODIFY COLUMN subscription_type_id INT AUTO_INCREMENT COMMENT 'Ідентифікатор типу підписки';
ALTER TABLE Subscriptions MODIFY COLUMN subscription_type VARCHAR(50) COMMENT 'Назва або тип підписки';
ALTER TABLE Subscriptions MODIFY COLUMN price DECIMAL(6,2) COMMENT 'Вартість підписки';
ALTER TABLE Subscriptions MODIFY COLUMN durability_days INT COMMENT 'Тривалість дії підписки в днях';

ALTER TABLE Active_subscriptions COMMENT = 'Активні підписки користувачів';

ALTER TABLE Active_subscriptions MODIFY COLUMN subscription_id INT AUTO_INCREMENT COMMENT 'Ідентифікатор активної підписки';
ALTER TABLE Active_subscriptions MODIFY COLUMN subscription_type_id INT COMMENT 'Тип підписки';
ALTER TABLE Active_subscriptions MODIFY COLUMN user_id INT COMMENT 'Користувач, який має підписку';
ALTER TABLE Active_subscriptions MODIFY COLUMN start_date DATE COMMENT 'Дата початку підписки';
ALTER TABLE Active_subscriptions MODIFY COLUMN end_date DATE COMMENT 'Дата завершення підписки';

ALTER TABLE TechnicalCharacteristics COMMENT = 'Технічні характеристики моделей самокатів';

ALTER TABLE TechnicalCharacteristics MODIFY COLUMN model_id INT COMMENT 'ID моделі';
ALTER TABLE TechnicalCharacteristics MODIFY COLUMN model_name VARCHAR(50) NOT NULL COMMENT 'Назва моделі';
ALTER TABLE TechnicalCharacteristics MODIFY COLUMN max_speed INT COMMENT 'Максимальна швидкість, км/год';
ALTER TABLE TechnicalCharacteristics MODIFY COLUMN battery_capacity INT COMMENT 'Ємність акумулятора (мАг)';
ALTER TABLE TechnicalCharacteristics MODIFY COLUMN weight DECIMAL(5,2) COMMENT 'Вага самоката (кг)';
ALTER TABLE TechnicalCharacteristics MODIFY COLUMN release_year YEAR COMMENT 'Рік випуску';

-- Vista de productos con inventario y descuentos
CREATE VIEW `view_products_with_inventory_and_discount` AS
SELECT 
    p.id_product,
    p.name AS product_name,
    p.description AS product_description,
    p.SKU,
    p.price,
    pi.quantity AS stock_quantity,
    d.name AS discount_name,
    d.discount_percent,
    (p.price - (p.price * (d.discount_percent / 100))) AS discounted_price
FROM 
    product p
LEFT JOIN 
    product_inventory pi ON p.inventory_id = pi.id_product_inventory
LEFT JOIN 
    discount d ON p.discount_id = d.id_discount;

-- Vista de órdenes con detalles de usuario y pago
CREATE VIEW `view_order_details` AS
SELECT 
    o.id_order_details,
    u.username AS user_name,
    u.first_name,
    u.last_name,
    u.address AS shipping_address,
    o.total AS order_total,
    pd.provider AS payment_provider,
    pd.status AS payment_status,
    o.created_at AS order_date
FROM 
    order_details o
JOIN 
    user u ON o.user_id = u.id_user
JOIN 
    payment_details pd ON o.payment_id = pd.id_payment_details;

-- Vista de historial de carrito de compras
CREATE VIEW `view_cart_history` AS
SELECT 
    ci.id_cart_item,
    ss.user_id,
    u.username,
    p.name AS product_name,
    ci.quantity,
    ss.total AS session_total,
    ss.created_at AS session_date
FROM 
    cart_item ci
JOIN 
    shopping_session ss ON ci.session_id = ss.id_shopping_session
JOIN 
    product p ON ci.product_id = p.id_product
JOIN 
    user u ON ss.user_id = u.id_user;

-- Vista de usuarios con direcciones de envío
CREATE VIEW `view_user_addresses` AS
SELECT 
    u.id_user,
    u.username,
    u.first_name,
    u.last_name,
    ua.address_line1,
    ua.address_line2,
    ua.city,
    ua.postal_code,
    ua.country,
    ua.telephone,
    ua.mobile
FROM 
    user u
JOIN 
    user_address ua ON u.id_user = ua.user_id;

-- Vista de resumen de inventario
CREATE VIEW `view_inventory_summary` AS
SELECT 
    p.id_product,
    p.name AS product_name,
    pi.quantity AS available_stock,
    p.price
FROM 
    product_inventory pi
JOIN 
    product p ON pi.id_product_inventory = p.inventory_id;
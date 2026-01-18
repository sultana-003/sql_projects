
create database company ;
use company;
select * from books ;        
select * from customers;
select * from orders;

-- 1. Show order placed in November 2023.

select * from orders
where Order_Date between "2023-11-01" and "2023-11-30" ;

-- 2. Find the details of the most expensive book.
 
 select * from books 
 order by price desc
 limit 1 ;
 
 -- 3. Show all customers who ordered more than 1 quantity of a book.
 
 select * from orders
 where quantity > 1 ;
 
 -- 4. Retrive all orders where total amount exceeds $200.
 
 select * from orders
 where Total_Amount > 200 ;
 
 -- 5. List all genre available in the book table.
 
 select distinct genre from books ;
 
 -- 6. Find the book with the lowest stock.
 
 select min(Stock) as lowest_stock
 from books ;
 
 -- 7. Calculate the total revenue generated from all orders.
  
select sum(total_amount) as revenue
from orders ;

-- 8. Retrive the total number of books sold for each genre.

select b.genre, sum(o.quantity) as total_books_sold
from orders o
join books b
on o.book_id = b.book_id
group by b.genre ;

-- 9. Find the average price of books in the "Fantasy" genre.

select genre, avg(price) as avg_price
from books
where genre = "Fantasy" ;

-- 10. List customers who have placed at least 2 orders.

select customer_id, count(order_id) as total_order
from orders
group by customer_id
having count(order_id) > 2 ;

-- 11. Find the most frequently ordered book.

select o.book_id, b.title, count(o.order_id) as total_count
from orders o
join books b
on o.book_id = b.book_id
group by o.book_id, b.title
order by total_count desc
limit 1 ;

-- 12. Show the top 3 most expensive books of Fantast genre.

select * from books
where genre = "Fantasy"
order by price desc
limit 3 ;

-- 13. Retrive the total quantity of books sold by each number.

select b.author, sum(o.quantity) as total_book_sold
from orders o
join books b
on o.book_id = b.book_id
group by b.author ;

-- 14. List the cities where customers who spent over $300 are located.

select distinct c.city, o.total_amount
from orders o
join customers c
on o.customer_id = c.customer_id
where o.total_amount > 300 ;

-- 15. Find the customer who spent the most on orders.

select c.customer_id, c.name, sum(o.total_amount) as highest_spent
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.name
order by highest_spent desc
limit 1 ;
 
 




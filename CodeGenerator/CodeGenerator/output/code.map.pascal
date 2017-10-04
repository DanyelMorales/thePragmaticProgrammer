{Add a product }
{to the 'on-order' list }
AddProductMyNaame = packed record
	id: int;
	name: array[0..30] of char;
	order_code: int;
end;

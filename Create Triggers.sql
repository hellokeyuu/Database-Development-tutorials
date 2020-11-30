CREATE TABLE car_rentals(
	plate varchar(10) NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
	license_nr varchar(10) NOT NULL,
	CONSTRAINT unq_car_rentals_start UNIQUE (plate, start_date),
	CONSTRAINT unq_car_rentals_end UNIQUE (plate, end_date)
);

CREATE FUNCTION check_period(pl varchar(10),start_d date,end_d date)
RETURNS varchar(100) as $$
	BEGIN
		IF exists
		    (select plate from car_rentals where plate = pl and start_d <= end_date and end_d >= start_date)
		then
			RAISE EXCEPTION 'fail';
		
		ELSE RETURN 'succeed';
		END IF;
	END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION check_p() 
RETURNS TRIGGER as $$
	BEGIN
		IF exists
		    (select plate from car_rentals where plate = NEW.PLATE 
		    									and (NEW.START_DATE <= end_date) 
		    									and (NEW.END_DATE >= start_date)
		    									and license_nr <> NEW.license_nr)

		then
			RAISE EXCEPTION 'fail';
		END IF;
	RETURN NEW;
	END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER TRIG
BEFORE INSERT OR UPDATE ON car_rentals FOR EACH ROW
EXECUTE PROCEDURE check_p();





INSERT INTO car_rentals VALUES ('2-F4ST','2015-02-02', '2015-02-11', 'DI123')
UPDATE car_rentals SET start_date = '2015-02-01', end_date = '2015-02-10'
INSERT INTO car_rentals VALUES ('SP33DY', '2015-01-20', '2015-02-05', 'DI234')
UPDATE car_rentals SET plate = '2-F4ST' WHERE plate = 'SP33DY'
INSERT INTO car_rentals VALUES ('2-F4ST', '2015-02-10', '2015-02-15', 'DI234')
INSERT INTO car_rentals VALUES ('2-F4ST', '2015-01-20', '2015-02-15', 'DI234')
INSERT INTO car_rentals VALUES ('2-F4ST', '2015-02-02', '2015-02-09', 'DI234')
INSERT INTO car_rentals VALUES ('2-F4ST', '2015-03-01', '2015-03-10', 'DI234')











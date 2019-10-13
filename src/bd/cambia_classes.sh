cat > $0.sql << fin
select * from menus_subvistas
fin
psql inicio -U inicio -h localhost  < $0.sql


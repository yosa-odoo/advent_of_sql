select distinct
    first_value(elf_id) over (partition by primary_skill order by years_experience desc, elf_id) as max,
    first_value(elf_id) over (partition by primary_skill order by years_experience, elf_id) as min,
    primary_skill
from workshop_elves;

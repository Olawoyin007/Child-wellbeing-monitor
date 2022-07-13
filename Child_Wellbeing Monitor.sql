--Creating Database For Child Wellbeing Montior
USE master;
GO
CREATE DATABASE Olawoyin_Coursework;


--Transforming India dataset into India Table using Data-dictionary
select

childid 'Child ID',

[round] 'Round of survey',

cast(dint as date) 'Interview_Date',

commid 'Community_ID',

clustid 'Sentinel_site ID',

case
		when region=24 then replace(region, 24,'Others')
		when region=23 then replace(region, 23,'Telangana')
		when region=77 then replace(region, 77,'Not known')
		when region=22 then replace(region, 22,'Rayalaseema')
		when region=21 then replace(region, 21,'Coastal Andhra')
	else
		null
	end		'Region',

case
		when chlang = 22 then replace(chlang, 22, 'Hindi')
		when chlang = 23 then replace(chlang, 23, 'urdu')
		when chlang = 24 then replace(chlang, 24, 'Oria')
		when chlang = 25 then replace(chlang, 25, 'Kannada')
		when chlang = 26 then replace(chlang, 26, 'Marati')
		when chlang = 27 then replace(chlang, 27, 'Tamil')
		when chlang = 28 then replace(chlang, 28, 'Local dialect')
		when chlang = 10 then replace(chlang, 10, 'other')
		when chlang = 21 then replace(chlang, 21, 'Telugu')
		when chlang = 88 then replace(chlang, 88, 'N/A')
		when chlang = 79 then replace(chlang, 79, 'Refused to answer')
		when chlang = 99 then replace(chlang, 99, 'Missing')
		when chlang = 77 then replace(chlang, 77, 'NK')
	else
		cast(chlang as nvarchar)
	end
	as 'Child_language',

case
		when chethnic  = 99 then replace(chethnic, 99, 'Not known')
		when chethnic  = 100 then replace(chethnic, 100, 'Other, Hindu')
		when chethnic  = 101 then replace(chethnic, 101, 'Other, Muslim')
		when chethnic  = 102 then replace(chethnic, 102, 'Other, Buddhist') 
		when chethnic  = 104 then replace(chethnic, 104, 'Other, Christian')
		when chethnic  = 14 then replace(chethnic, 14, 'None')
		when chethnic  = 21 then replace(chethnic, 21, 'SC')
		when chethnic  = 22 then replace(chethnic, 22, 'ST')
		when chethnic  = 23 then replace(chethnic, 23, 'BC')
		when chethnic  = 24 then replace(chethnic, 24, 'Other')	

	else
		null
	end
	 as 'Ethnic_group',

case
	when chldrel = 1 then replace(chldrel, 1, 'Christian')
	when chldrel = 2 then replace(chldrel, 2, 'Muslim')
	when chldrel = 3 then replace(chldrel, 3, 'Buddhist')
	when chldrel = 4 then replace(chldrel, 4, 'Hindu')
	when chldrel = 5 then replace(chldrel, 5, 'Catholic')
	when chldrel = 6 then replace(chldrel, 6, 'Protestant')
	when chldrel = 7 then replace(chldrel, 7, 'Orthodox')
	when chldrel = 8 then replace(chldrel, 8, 'Sikh')
	when chldrel = 9 then replace(chldrel, 9, 'Evangelist')
	when chldrel = 10 then replace(chldrel, 10, 'Mormon')
	when chldrel = 11 then replace(chldrel, 11, 'Ancestor worship')
	when chldrel = 12 then replace(chldrel, 12, 'Hao Hao')
	when chldrel = 13 then replace(chldrel, 13, 'Cao Dai')
	when chldrel = 14 then replace(chldrel, 14, 'None')
	when chldrel = 15 then replace(chldrel, 15, 'Other')
	when chldrel = 99 then replace(chldrel, 99, 'NK')

ELSE NULL
END
	AS 'Child_Religion',

iif(chsex=1,'Male', iif(chsex=2,'Female', cast(chsex as nvarchar))) 'Sex',

round(bmi,1) 'Calculated_BMI',

iif(chhprob=1, 'Yes','No') 'Longterm_health_problem',

iif(chdisability=1, 'Yes','No') 'Permanent_Disability',

case
	when chhealth=1 then replace(chhealth,1,'Very Poor')
	when chhealth=2 then replace(chhealth,2,'Poor')
	when chhealth=3 then replace(chhealth,3,'Average')
	when chhealth=4 then replace(chhealth,4,'Good')
	when chhealth=5 then replace(chhealth,5,'Very Good')
else
	null
end as 'Health_state',

case
	when chhrel=1 then replace(chhrel,1,'Same')
	when chhrel=2 then replace(chhrel,2,'Better')
	when chhrel=3 then replace(chhrel,3,'Worse')
else
	null
end as 'Health compared with peers',

iif(cladder>1,cladder,null) '9-step ladder',

iif(deceased=1,'Yes','No') 'Deceased',

iif(typesite=1,'Urban',iif(typesite=2,'Rural',null)) 'Area of Residence',

iif(childloc=0,'No',iif(childloc=1,'Yes',null)) 'Curently_living_Household',

case
	when chsmoke = 1 then replace(chsmoke, 1, 'Every day')
	when chsmoke = 2 then replace(chsmoke, 2, 'At least once a week')
	when chsmoke = 3 then replace(chsmoke, 3, 'At least once a month')
	when chsmoke = 4 then replace(chsmoke, 4, 'Hardly ever')
	when chsmoke = 5 then replace(chsmoke, 5, 'I never smoke cigarettes')
else
	replace(chsmoke, ' ', 'None')
end as 'Smoking_Rate',

iif(chalcohol=1, 'Yes','No') 'Alcohol_1/week',

iif(chrephealth1<1,0,chrephealth1) '5 reproductive health_questions',

iif(marrcohab=1, 'Yes', 'No') as 'Ever Married/Cohabited',

iif(birth=1, 'Yes', 'No') as 'Has a Child',

iif(marrcohab_age>1,marrcohab_age, null) 'Age at Offspring Birth',

iif(chhprob=1, 'Yes','No') 'Longterm Health_Issue',

case
	when caredu=0 then replace(caredu,0,'None')
	when caredu=1 then replace(caredu,1,'Grade 1')
	when caredu=2 then replace(caredu,2,'Grade 2')
	when caredu=3 then replace(caredu,3,'Grade 3')
	when caredu=4 then replace(caredu,4,'Grade 4')
	when caredu=5 then replace(caredu,5,'Grade 5')
	when caredu=6 then replace(caredu,6,'Grade 6')
	when caredu=7 then replace(caredu,7,'Grade 7')
	when caredu=8 then replace(caredu,8,'Grade 8')
	when caredu=9 then replace(caredu,9,'Grade 9')
	when caredu=10 then replace(caredu,10,'Grade 10')
	when caredu=11 then replace(caredu,11,'Grade 11')
	when caredu=12 then replace(caredu,12,'Grade 12')
	when caredu=13 then replace(caredu,13,'Vocational, technical college')
	when caredu=14 then replace(caredu,14,'University')
	when caredu=15 then replace(caredu,15,'Masters, doctorate')
	when caredu=29 then replace(caredu,29,'Religious education')
	when caredu=28 then replace(caredu,28,'Adult literacy')
	when caredu=30 then replace(caredu,30,'Other')
else
	null
end as 'Caregiver education_level',

case
	when carehead=1 then replace(carehead,1,'Caregiver is household head')
	when carehead=2 then replace(carehead,2,'Caregiver is partner')
	when carehead=3 then replace(carehead,3,'Other')
else
	null
end as 'Caregiver relationship household_Head',

careage 'Caregiver Age',

iif(caresex=1,'Male',iif(caresex=2,'Female',null)) 'Caregiver Sex',

case
	when carerel=1 then replace(carerel,1,'Biological parent')
	when carerel=2 then replace(carerel,2,'Non-Biological parent')
	when carerel=3 then replace(carerel,3,'Grandparent')
	when carerel=4 then replace(carerel,4,'Uncle/aunt')
	when carerel=5 then replace(carerel,5,'Sibling')
	when carerel=6 then replace(carerel,6,'Other-relative')
	when carerel=7 then replace(carerel,7,'Other-nonrelative')
	when carerel=8 then replace(carerel,8,'Partner/spouse of YL child')
	when carerel=9 then replace(carerel,9,'Father-in-law/mother-in-law')
else
	null
end as 'Caregiver-child relationship',

careladder 'Caregiver 9-Step Ladder',

case
	when dadedu=0 then replace(dadedu,0,'None')
	when dadedu=1 then replace(dadedu,1,'Grade 1')
	when dadedu=2 then replace(dadedu,2,'Grade 2')
	when dadedu=3 then replace(dadedu,3,'Grade 3')
	when dadedu=4 then replace(dadedu,4,'Grade 4')
	when dadedu=5 then replace(dadedu,5,'Grade 5')
	when dadedu=6 then replace(dadedu,6,'Grade 6')
	when dadedu=7 then replace(dadedu,7,'Grade 7')
	when dadedu=8 then replace(dadedu,8,'Grade 8')
	when dadedu=9 then replace(dadedu,9,'Grade 9')
	when dadedu=10 then replace(dadedu,10,'Grade 10')
	when dadedu=11 then replace(dadedu,11,'Grade 11')
	when dadedu=12 then replace(dadedu,12,'Grade 12')
	when dadedu=13 then replace(dadedu,13,'Vocational, tecnical college')
	when dadedu=14 then replace(dadedu,14,'University')
	when dadedu=15 then replace(dadedu,15,'Masters, doctorate')
	when dadedu=29 then replace(dadedu,29,'Religious education')
	when dadedu=28 then replace(dadedu,28,'Adult literacy')
	when dadedu=30 then replace(dadedu,30,'Other')
else
	null
end as 'Dad education_level',

case
	when dadlive=1 then replace(dadlive,1,'Lives in the household')
	when dadlive=2 then replace(dadlive,2,'Does not live in household')
	when dadlive=3 then replace(dadlive,3,'Has died')
else
	null
end as 'Location of Father',

dadage 'Father Age',

iif(dadcantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Father Literate',

iif(dadyrdied>0,dadyrdied,null) 'Father Death',

Case
	when momedu=0 then replace(momedu,0,'None')
	when momedu=1 then replace(momedu,1,'Grade 1')
	when momedu=2 then replace(momedu,2,'Grade 2')
	when momedu=3 then replace(momedu,3,'Grade 3')
	when momedu=4 then replace(momedu,4,'Grade 4')
	when momedu=5 then replace(momedu,5,'Grade 5')
	when momedu=6 then replace(momedu,6,'Grade 6')
	when momedu=7 then replace(momedu,7,'Grade 7')
	when momedu=8 then replace(momedu,8,'Grade 8')
	when momedu=9 then replace(momedu,9,'Grade 9')
	when momedu=10 then replace(momedu,10,'Grade 10')
	when momedu=11 then replace(momedu,11,'Grade 11')
	when momedu=12 then replace(momedu,12,'Grade 12')
	when momedu=13 then replace(momedu,13,'Vocational, tecnical college')
	when momedu=14 then replace(momedu,14,'University')
	when momedu=15 then replace(momedu,15,'Masters, doctorate')
	when momedu=29 then replace(momedu,29,'Religious education')
	when momedu=28 then replace(momedu,28,'Adult literacy')
	when momedu=30 then replace(momedu,30,'Other')
else
	null
end as 'Mother education_level',

case
	when momlive=1 then replace(momlive,1,'Lives in the household')
	when momlive=2 then replace(momlive,2,'Does not live in household')
	when momlive=3 then replace(momlive,3,'Has died')
else
	null
end as 'Location of Mother',

momage 'Mother Age',

iif(momcantread=0,'No',iif(momcantread=1,'Yes',null)) 'Mother Literate',

iif(momyrdied>0,momyrdied,null) 'Mother Death',

case
	when headedu=0 then replace(headedu,0,'None')
	when headedu=1 then replace(headedu,1,'Grade 1')
	when headedu=2 then replace(headedu,2,'Grade 2')
	when headedu=3 then replace(headedu,3,'Grade 3')
	when headedu=4 then replace(headedu,4,'Grade 4')
	when headedu=5 then replace(headedu,5,'Grade 5')
	when headedu=6 then replace(headedu,6,'Grade 6')
	when headedu=7 then replace(headedu,7,'Grade 7')
	when headedu=8 then replace(headedu,8,'Grade 8')
	when headedu=9 then replace(headedu,9,'Grade 9')
	when headedu=10 then replace(headedu,10,'Grade 10')
	when headedu=11 then replace(headedu,11,'Grade 11')
	when headedu=12 then replace(headedu,12,'Grade 12')
	when headedu=13 then replace(headedu,13,'Vocational, tecnical college')
	when headedu=14 then replace(headedu,14,'University')
	when headedu=15 then replace(headedu,15,'Masters, doctorate')
	when headedu=29 then replace(headedu,29,'Religious education')
	when headedu=28 then replace(headedu,28,'Adult literacy')
	when headedu=30 then replace(headedu,30,'Other')
else
	null
end as 'Household_head education',

headage 'Household_head Age',

iif(headsex=1,'Male',iif(headsex=2,'Female',null)) 'Household_head Sex',

case
	when headrel=0 then replace(headrel,0,'YL child')
	when headrel=1 then replace(headrel,1,'Biological parent')
	when headrel=2 then replace(headrel,2,'Non-Biological parent')
	when headrel=3 then replace(headrel,3,'Grandparent')
	when headrel=4 then replace(headrel,4,'Uncle/aunt')
	when headrel=5 then replace(headrel,5,'Sibling')
	when headrel=6 then replace(headrel,6,'Other-relative')
	when headrel=7 then replace(headrel,7,'Other-nonrelative')
	when headrel=8 then replace(headrel,8,'Partner/spouse of YL child')
	when headrel=9 then replace(headrel,9,'Father-in-law/mother-in-law')
else
	null
end as 'Household_head Child_Relationship',

hhsize 'Household Size',

male05+male612+male1317 'Male_Kids in Household',

male61+male1860 'Male_Adults in Household',

female05+female612+female1317 'Female_Kids in Household',

female1860+female61 'Female_Adults in Household',


iif(preprim=1,'Yes',iif(preprim=0,'No', null)) 'Pre-primary school',

timesch 'Travel_time to school(min)',

agegr1 'Age @ starting of grade1',

case
	when enrol=0 then replace(enrol,0,'No')
	when enrol=1 then replace(enrol,1,'Yes')
	when enrol=99 then replace(enrol,99,'Missing')
	when enrol=77 then replace(enrol,77,'NK')
	when enrol=88 then replace(enrol,88,'N/A')
else
	null
end as 'currently_enrolled',

case
	when entype=1 then replace(entype,1,'Private')
	when entype=2 then replace(entype,2,'ngo/charity/religious')
	when entype=3 then replace(entype,3,'public')
	when entype=4 then replace(entype,4,'informal/non-formal community')
	when entype=5 then replace(entype,5,'vocational school')
	when entype=6 then replace(entype,6,'in=charitable trust')
	when entype=7 then replace(entype,7,'india=bridge school')
	when entype=8 then replace(entype,8,'mix of public and private')
	when entype=9 then replace(entype,9,'vn=branch school')
	when entype=10 then replace(entype,10,'vn=main school')
	when entype=11 then replace(entype,11,'Other')
	when entype=77 then replace(entype,77,'nk')
	when entype=99 then replace(entype,99,'missing')
else
	null
end as 'School_type',

case
	when engrade=0 then replace(engrade,0,'None')
	when engrade=1 then replace(engrade,1,'Grade 1')
	when engrade=2 then replace(engrade,2,'Grade 2')
	when engrade=3 then replace(engrade,3,'Grade 3')
	when engrade=4 then replace(engrade,4,'Grade 4')
	when engrade=5 then replace(engrade,5,'Grade 5')
	when engrade=6 then replace(engrade,6,'Grade 6')
	when engrade=7 then replace(engrade,7,'Grade 7')
	when engrade=8 then replace(engrade,8,'Grade 8')
	when engrade=9 then replace(engrade,9,'Grade 9')
	when engrade=10 then replace(engrade,10,'Grade 10')
	when engrade=11 then replace(engrade,11,'Grade 11')
	when engrade=12 then replace(engrade,12,'Grade 12')
	when engrade=13 then replace(engrade,13,'Post-secondary/technological institute')
	when engrade=14 then replace(engrade,14,'Vocational')
	when engrade=15 then replace(engrade,15,'University degree(graduate')
	when engrade=16 then replace(engrade,16,'University degree(postgraduate')
	when engrade=77 then replace(engrade,77,'Not known')
	when engrade=28 then replace(engrade,28,'Adult Literacy')
	when engrade=29 then replace(engrade,29,'Religious education')
	when engrade=100 then replace(engrade,100,'Pre-primary')
else
	null
end as 'Current_grade',

case
	when levlread=1 then replace(levlread,1,'cannot read anything')
	when levlread=2 then replace(levlread,2,'reads letters')
	when levlread=3 then replace(levlread,3,'reads word')
	when levlread=4 then replace(levlread,4,'reads sentence')
else
	null
end as 'Reading_level',

case
	when levlwrit=1 then replace(levlwrit,1,'no')
	when levlwrit=2 then replace(levlwrit,2,'yes with difficulty or errors')
	when levlwrit=3 then replace(levlwrit,3,'yes without difficulty or errors')
else
	null
end as 'Writing_level',

iif(literate=1,'Yes',iif(literate=0,'No',null)) 'Literate',

hsleep 'Sleeping',

hschool 'School',

case
	when chsmoke = 1 then replace(chsmoke, 1, 'Every day')
	when chsmoke = 2 then replace(chsmoke, 2, 'At least once a week')
	when chsmoke = 3 then replace(chsmoke, 3, 'At least once a month')
	when chsmoke = 4 then replace(chsmoke, 4, 'Hardly ever')
	when chsmoke = 5 then replace(chsmoke, 5, 'I never smoke cigarettes')
else
	NULL
end as 'Rate_of_Smoking',

iif(commwork>0,commwork,null) 'Work commute_to&fro(mins)',

iif(chalcohol=1, 'Yes','No') 'Alcohol_use_1/week',

iif(elecq=0,'No',iif(elecq=1,'Yes',null)) 'Electricity_Access',

hcare 'Caring for family',

hchore 'Chores',

sv 'Access to Services_Index',

iif(aniany=0,'No',iif(aniany=1,'Yes',null)) 'Household_owned_livestock',

htask 'Tasks',

hwork 'Work',

hstudy 'Studying',

hplay 'Playing',

iif(commsch>0,commsch,null) 'School commute_to&fro(mins)',

wi 'Wealth_Index',

hq 'Housing Quality_Index',

cd 'Consumer Durables_Index',

iif(drwaterq=0,'No',iif(drwaterq=1,'Yes',null)) 'Safe Drinking Water_Access',

iif(ownlandhse=0,'No',iif(ownlandhse=1,'Yes',null)) 'Household_owned_land',

iif(ownhouse=0,'No',iif(ownhouse=1,'Yes',null)) 'Household_owned_house',

iif((cast(shcrime1 as int)+
	cast(shcrime2 as int)+
	cast(shcrime3 as int)+
	cast(shcrime4 as int)+
	cast(shcrime5 as int)+
	cast(shcrime6 as int)+
	cast(shcrime8 as int))>0,'Yes','No') 'Losses due to crime',

iif(credit=0,'No',iif(credit=1,'Yes',null)) 'Household got loan(12months)',

case
	when foodsec=1 then replace(foodsec,1,'we always eat enough of what we want')
	when foodsec=2 then replace(foodsec,2,'we eat enough but not always what we would like')
	when foodsec=3 then replace(foodsec,3,'we sometimes do not eat enough')
	when foodsec=4 then replace(foodsec,4,'we frequently do not eat enough')
else
	null
end as 'Household_food situation in the last 12_months'

into India_Table
from india_dataset;



--Transforming Peru dataset into Peru Table using Data-dictionary
select

childid 'Child ID',

[round] 'Round of survey',

cast(dint as date) 'Interview_Date',

placeid 'Community_ID',

clustid 'Sentinel_site ID',

case
		when region=32 then replace(region, 32,'Sierra')
		when region=33 then replace(region, 33,'Selva')
		when region=88 then replace(region, 88,'N/A')
		when region=31 then replace(region, 31,'Costa')
	else
		null
	end		'Region',

case
		when chlang = 32 then replace(chlang, 32, 'Quechua')
		when chlang = 33 then replace(chlang, 33, 'Aymara')
		when chlang = 34 then replace(chlang,34, 'Native from Jungle')
		when chlang = 35 then replace(chlang, 35, 'Spanish & quechua')
		when chlang = 36 then replace(chlang, 36, 'Spanish & aymara')
		when chlang = 37 then replace(chlang, 37, 'Nomatsiguenga(native language in jungle')
		when chlang = 10 then replace(chlang, 10, 'other')
		when chlang = 31 then replace(chlang, 31, 'Spanish')
		when chlang = 50 then replace(chlang, 50, 'mute or difficulty speaking')
		when chlang = 88 then replace(chlang, 88, 'N/A')
		when chlang = 79 then replace(chlang, 79, 'Refused to answer')
		when chlang = 99 then replace(chlang, 99, 'Missing')
		when chlang = 77 then replace(chlang, 77, 'NK')
	else
		cast(chlang as nvarchar)
	end
	as 'Child_language',

case
		when chethnic = 31 then replace(chethnic, 31, 'White')
		when chethnic = 32 then replace(chethnic, 32, 'Mestizo')
		when chethnic = 33 then replace(chethnic, 33, 'Native of the Amazon')
		when chethnic = 34 then replace(chethnic, 34, 'Negro')
		when chethnic = 35 then replace(chethnic, 35, 'Asiatic')
	else
		null
	end
	 as 'Ethnic_group',

case
	when chldrel = 1 then replace(chldrel, 1, 'Christian')
	when chldrel = 2 then replace(chldrel, 2, 'Muslim')
	when chldrel = 3 then replace(chldrel, 3, 'Buddhist')
	when chldrel = 4 then replace(chldrel, 4, 'Hindu')
	when chldrel = 5 then replace(chldrel, 5, 'Catholic')
	when chldrel = 6 then replace(chldrel, 6, 'Protestant')
	when chldrel = 7 then replace(chldrel, 7, 'Orthodox')
	when chldrel = 8 then replace(chldrel, 8, 'Sikh')
	when chldrel = 9 then replace(chldrel, 9, 'Evangelist')
	when chldrel = 10 then replace(chldrel, 10, 'Mormon')
	when chldrel = 11 then replace(chldrel, 11, 'Ancestor worship')
	when chldrel = 12 then replace(chldrel, 12, 'Hao Hao')
	when chldrel = 13 then replace(chldrel, 13, 'Cao Dai')
	when chldrel = 14 then replace(chldrel, 14, 'None')
	when chldrel = 15 then replace(chldrel, 15, 'Other')
	when chldrel = 99 then replace(chldrel, 99, 'NK')

ELSE NULL
END
	AS 'Child_Religion',

iif(chsex=1,'Male', iif(chsex=2,'Female', cast(chsex as nvarchar))) 'Sex',

round(bmi,1) 'Calculated_BMI',

iif(chhprob=1, 'Yes','No') 'Longterm_health_problem',

iif(chdisability=1, 'Yes','No') 'Permanent_Disability',

case
	when chhealth=1 then replace(chhealth,1,'Very Poor')
	when chhealth=2 then replace(chhealth,2,'Poor')
	when chhealth=3 then replace(chhealth,3,'Average')
	when chhealth=4 then replace(chhealth,4,'Good')
	when chhealth=5 then replace(chhealth,5,'Very Good')
else
	null
end as 'Health_state',

case
	when chhrel=1 then replace(chhrel,1,'Same')
	when chhrel=2 then replace(chhrel,2,'Better')
	when chhrel=3 then replace(chhrel,3,'Worse')
else
	null
end as 'Health compared with peers',

iif(cladder>1,cladder,null) '9-step ladder',

iif(deceased=1,'Yes','No') 'Deceased',

iif(typesite=1,'Urban',iif(typesite=2,'Rural',null)) 'Area of Residence',

iif(childloc=0,'No',iif(childloc=1,'Yes',null)) 'Curently_living_Household',

case
	when chsmoke = 1 then replace(chsmoke, 1, 'Every day')
	when chsmoke = 2 then replace(chsmoke, 2, 'At least once a week')
	when chsmoke = 3 then replace(chsmoke, 3, 'At least once a month')
	when chsmoke = 4 then replace(chsmoke, 4, 'Hardly ever')
	when chsmoke = 5 then replace(chsmoke, 5, 'I never smoke cigarettes')
else
	replace(chsmoke, ' ', 'None')
end as 'Smoking_Rate',

iif(chalcohol=1, 'Yes','No') 'Alcohol_1/week',

iif(chrephealth1<1,0,chrephealth1) '5 reproductive health_questions',

iif(marrcohab=1, 'Yes', 'No') as 'Ever Married/Cohabited',

iif(birth=1, 'Yes', 'No') as 'Has a Child',

iif(marrcohab_age>1,marrcohab_age, null) 'Age at Offspring Birth',

iif(chhprob=1, 'Yes','No') 'Longterm Health_Issue',

case
	when caredu=0 then replace(caredu,0,'None')
	when caredu=1 then replace(caredu,1,'Grade 1')
	when caredu=2 then replace(caredu,2,'Grade 2')
	when caredu=3 then replace(caredu,3,'Grade 3')
	when caredu=4 then replace(caredu,4,'Grade 4')
	when caredu=5 then replace(caredu,5,'Grade 5')
	when caredu=6 then replace(caredu,6,'Grade 6')
	when caredu=7 then replace(caredu,7,'Grade 7')
	when caredu=8 then replace(caredu,8,'Grade 8')
	when caredu=9 then replace(caredu,9,'Grade 9')
	when caredu=10 then replace(caredu,10,'Grade 10')
	when caredu=11 then replace(caredu,11,'Grade 11')
	when caredu=13 then replace(caredu,13,'Technical,pedagogical,CETPRO(incomplete)')
	when caredu=14 then replace(caredu,14,'Technical,pedagogical,CETPRO(complete)')
	when caredu=15 then replace(caredu,15,'University(incomplete)')
	when caredu=16 then replace(caredu,16,'University(incomplete)')
	when caredu=28 then replace(caredu,28,'Adult literacy')
	when caredu=30 then replace(caredu,30,'Other')
else
	null
end as 'Caregiver education_level',

case
	when carehead=1 then replace(carehead,1,'Caregiver is household head')
	when carehead=2 then replace(carehead,2,'Caregiver is partner')
	when carehead=3 then replace(carehead,3,'Other')
else
	null
end as 'Caregiver relationship household_Head',

careage 'Caregiver Age',

iif(caresex=1,'Male',iif(caresex=2,'Female',null)) 'Caregiver Sex',

case
	when carerel=1 then replace(carerel,1,'Biological parent')
	when carerel=2 then replace(carerel,2,'Non-Biological parent')
	when carerel=3 then replace(carerel,3,'Grandparent')
	when carerel=4 then replace(carerel,4,'Uncle/aunt')
	when carerel=5 then replace(carerel,5,'Sibling')
	when carerel=6 then replace(carerel,6,'Other-relative')
	when carerel=7 then replace(carerel,7,'Other-nonrelative')
	when carerel=8 then replace(carerel,8,'Partner/spouse of YL child')
	when carerel=9 then replace(carerel,9,'Father-in-law/mother-in-law')
else
	null
end as 'Caregiver-child relationship',

careladder 'Caregiver 9-Step Ladder',

case
	when dadedu=0 then replace(dadedu,0,'None')
	when dadedu=1 then replace(dadedu,1,'Grade 1')
	when dadedu=2 then replace(dadedu,2,'Grade 2')
	when dadedu=3 then replace(dadedu,3,'Grade 3')
	when dadedu=4 then replace(dadedu,4,'Grade 4')
	when dadedu=5 then replace(dadedu,5,'Grade 5')
	when dadedu=6 then replace(dadedu,6,'Grade 6')
	when dadedu=7 then replace(dadedu,7,'Grade 7')
	when dadedu=8 then replace(dadedu,8,'Grade 8')
	when dadedu=9 then replace(dadedu,9,'Grade 9')
	when dadedu=10 then replace(dadedu,10,'Grade 10')
	when dadedu=11 then replace(dadedu,11,'Grade 11')
	when dadedu=13 then replace(dadedu,13,'Technical,pedagogical,CETPRO(incomplete)')
	when dadedu=14 then replace(dadedu,14,'Technical,pedagogical,CETPRO(complete)')
	when dadedu=15 then replace(dadedu,15,'University(incomplete)')
	when dadedu=16 then replace(dadedu,16,'University(complete)')
	when dadedu=28 then replace(dadedu,28,'Adult literacy')
	when dadedu=30 then replace(dadedu,30,'Other')
else
	null
end as 'Dad education_level',

case
	when dadlive=1 then replace(dadlive,1,'Lives in the household')
	when dadlive=2 then replace(dadlive,2,'Does not live in household')
	when dadlive=3 then replace(dadlive,3,'Has died')
else
	null
end as 'Location of Father',

dadage 'Father Age',

iif(dadcantread=0,'No',iif(dadcantread=1,'Yes',null)) 'Father Literate',

iif(dadyrdied>0,dadyrdied,null) 'Father Death',

case
	when momedu=0 then replace(momedu,0,'None')
	when momedu=1 then replace(momedu,1,'Grade 1')
	when momedu=2 then replace(momedu,2,'Grade 2')
	when momedu=3 then replace(momedu,3,'Grade 3')
	when momedu=4 then replace(momedu,4,'Grade 4')
	when momedu=5 then replace(momedu,5,'Grade 5')
	when momedu=6 then replace(momedu,6,'Grade 6')
	when momedu=7 then replace(momedu,7,'Grade 7')
	when dadedu=8 then replace(momedu,8,'Grade 8')
	when momedu=9 then replace(momedu,9,'Grade 9')
	when momedu=10 then replace(momedu,10,'Grade 10')
	when momedu=11 then replace(momedu,11,'Grade 11')
	when momedu=13 then replace(momedu,13,'Technical,pedagogical,CETPRO(incomplete)')
	when momedu=14 then replace(momedu,14,'Technical,pedagogical,CETPRO(complete)')
	when momedu=15 then replace(momedu,15,'University(incomplete)')
	when momedu=16 then replace(momedu,16,'University(complete)')
	when momedu=28 then replace(momedu,28,'Adult literacy')
	when momedu=30 then replace(momedu,30,'Other')
else
	null
end as 'Mother education_level',

case
	when momlive=1 then replace(momlive,1,'Lives in the household')
	when momlive=2 then replace(momlive,2,'Does not live in household')
	when momlive=3 then replace(momlive,3,'Has died')
else
	null
end as 'Location of Mother',

momage 'Mother Age',

iif(momcantread=0,'No',iif(momcantread=1,'Yes',null)) 'Mother Literate',

iif(momyrdied>0,momyrdied,null) 'Mother Death',

case
	when headedudu=0 then replace(headedudu,0,'None')
	when headedudu=1 then replace(headedudu,1,'Grade 1')
	when headedudu=2 then replace(headedudu,2,'Grade 2')
	when headedudu=3 then replace(headedudu,3,'Grade 3')
	when headedudu=4 then replace(headedudu,4,'Grade 4')
	when headedudu=5 then replace(headedudu,5,'Grade 5')
	when headedudu=6 then replace(headedudu,6,'Grade 6')
	when headedudu=7 then replace(headedudu,7,'Grade 7')
	when headedudu=8 then replace(headedudu,8,'Grade 8')
	when headedudu=9 then replace(headedudu,9,'Grade 9')
	when headedudu=10 then replace(headedudu,10,'Grade 10')
	when headedudu=11 then replace(headedudu,11,'Grade 11')
	when headedudu=13 then replace(headedudu,13,'Technical,pedagogical,CETPRO(incomplete)')
	when headedudu=14 then replace(headedudu,14,'Technical,pedagogical,CETPRO(complete)')
	when headedudu=15 then replace(headedudu,15,'University(incomplete)')
	when headedudu=16 then replace(headedudu,16,'University(complete)')
	when headedudu=28 then replace(headedudu,28,'Adult literacy')
	when headedudu=30 then replace(headedudu,30,'Other')
else
	null
end as 'Household_head education',

headage 'Household_head Age',

iif(headsex=1,'Male',iif(headsex=2,'Female',null)) 'Household_head Sex',

case
	when headrel=0 then replace(headrel,0,'YL child')
	when headrel=1 then replace(headrel,1,'Biological parent')
	when headrel=2 then replace(headrel,2,'Non-Biological parent')
	when headrel=3 then replace(headrel,3,'Grandparent')
	when headrel=4 then replace(headrel,4,'Uncle/aunt')
	when headrel=5 then replace(headrel,5,'Sibling')
	when headrel=6 then replace(headrel,6,'Other-relative')
	when headrel=7 then replace(headrel,7,'Other-nonrelative')
	when headrel=8 then replace(headrel,8,'Partner/spouse of YL child')
	when headrel=9 then replace(headrel,9,'Father-in-law/mother-in-law')
else
	null
end as 'Household_head Child_Relationship',

hhsize 'Household Size',

male05+male612+male1317 'Male_Kids in Household',

male61+male1860 'Male_Adults in Household',

female05+female612+female1317 'Female_Kids in Household',

female1860+female61 'Female_Adults in Household',

iif(preprim=1,'Yes',iif(preprim=0,'No', null)) 'Pre-primary school',

timesch 'Travel_time to school(min)',

agegr1 'Age @ starting of grade1',

case
	when enrol=0 then replace(enrol,0,'No')
	when enrol=1 then replace(enrol,1,'Yes')
	when enrol=99 then replace(enrol,99,'Missing')
	when enrol=77 then replace(enrol,77,'NK')
	when enrol=88 then replace(enrol,88,'N/A')
else
	null
end as 'currently_enrolled',

case
	when entype=1 then replace(entype,1,'Private')
	when entype=2 then replace(entype,2,'Public')
	when entype=3 then replace(entype,3,'Half public/private')
	when entype=4 then replace(entype,4,'Other')
	when entype=88 then replace(entype,88,'Not available')
else
	null
end as 'School_type',

case
	when engrade=0 then replace(engrade,0,'None')
	when engrade=1 then replace(engrade,1,'Grade 1')
	when engrade=2 then replace(engrade,2,'Grade 2')
	when engrade=3 then replace(engrade,3,'Grade 3')
	when engrade=4 then replace(engrade,4,'Grade 4')
	when engrade=5 then replace(engrade,5,'Grade 5')
	when engrade=6 then replace(engrade,6,'Grade 6')
	when engrade=7 then replace(engrade,7,'Year 1')
	when engrade=8 then replace(engrade,8,'Year 2')
	when engrade=9 then replace(engrade,9,'Year 3')
	when engrade=10 then replace(engrade,10,'Year 4')
	when engrade=11 then replace(engrade,11,'Year 5')
	when engrade=13 then replace(engrade,13,'Incomplete technical')
	when engrade=14 then replace(engrade,14,'Complete technical')
	when engrade=15 then replace(engrade,15,'Incomplete university')
	when engrade=16 then replace(engrade,16,'Complete university')
	when engrade=17 then replace(engrade,17,'Adult literacy program')
	when engrade=18 then replace(engrade,18,'Other')
	when engrade=19 then replace(engrade,19,'Masters')
	when engrade=20 then replace(engrade,20,'formal or informal preschool')
	when engrade=21 then replace(engrade,21,'Incomplete CETPRO/CEO')
	when engrade=22 then replace(engrade,22,'Complete CETPRO/CEO')
	when engrade=77 then replace(engrade,77,'Not known')
	when engrade=79 then replace(engrade,79,'Not available')
	when engrade=88 then replace(engrade,88,'missing')
	when engrade=100 then replace(engrade,100,'Pre-primary')
else
	null
end as 'Current_grade',

case
	when levlread=1 then replace(levlread,1,'cannot read anything')
	when levlread=2 then replace(levlread,2,'reads letters')
	when levlread=3 then replace(levlread,3,'reads word')
	when levlread=4 then replace(levlread,4,'reads sentence')
	when levlread=79 then replace(levlread,79,'refused to answer')
else
	null
end as 'Reading_level',

case
	when levlwrit=1 then replace(levlwrit,1,'no')
	when levlwrit=2 then replace(levlwrit,2,'yes with difficulty or errors')
	when levlwrit=3 then replace(levlwrit,3,'yes without difficulty or errors')
	when levlwrit=79 then replace(levlwrit,79,'refused to answer')
else
	null
end as 'Writing_level',

iif(literate=1,'Yes',iif(literate=0,'No',null)) 'Literate',

hsleep 'Sleeping',

hschool 'School',

case
	when chsmoke = 1 then replace(chsmoke, 1, 'Every day')
	when chsmoke = 2 then replace(chsmoke, 2, 'At least once a week')
	when chsmoke = 3 then replace(chsmoke, 3, 'At least once a month')
	when chsmoke = 4 then replace(chsmoke, 4, 'Hardly ever')
	when chsmoke = 5 then replace(chsmoke, 5, 'I never smoke cigarettes')
else
	NULL
end as 'Rate_of_Smoking',

iif(commwork>0,commwork,null) 'Work commute_to&fro(mins)',

iif(chalcohol=1, 'Yes','No') 'Alcohol_use_1/week',

iif(elecq=0,'No',iif(elecq=1,'Yes',null)) 'Electricity_Access',

hcare 'Caring for family',

hchore 'Chores',

sv 'Access to Services_Index',

iif(aniany=0,'No',iif(aniany=1,'Yes',null)) 'Household_owned_livestock',

htask 'Tasks',

hwork 'Work',

hstudy 'Studying',

hplay 'Playing',

iif(commsch>0,commsch,null) 'School commute_to&fro(mins)',

wi 'Wealth_Index',

hq 'Housing Quality_Index',

cd 'Consumer Durables_Index',

iif(drwaterq=0,'No',iif(drwaterq=1,'Yes',null)) 'Safe Drinking Water_Access',

iif(ownlandhse=0,'No',iif(ownlandhse=1,'Yes',null)) 'Household_owned_land',

iif(ownhouse=0,'No',iif(ownhouse=1,'Yes',null)) 'Household_owned_house',

iif((cast(shcrime1 as int)+
	cast(shcrime2 as int)+
	cast(shcrime3 as int)+
	cast(shcrime4 as int)+
	cast(shcrime5 as int)+
	cast(shcrime6 as int)+
	cast(shcrime8 as int))>0,'Yes','No') 'Losses due to crime',

iif(credit=0,'No',iif(credit=1,'Yes',null)) 'Household got loan(12months)',

case
	when foodsec=1 then replace(foodsec,1,'we always eat enough of what we want')
	when foodsec=2 then replace(foodsec,2,'we eat enough but not always what we would like')
	when foodsec=3 then replace(foodsec,3,'we sometimes do not eat enough')
	when foodsec=4 then replace(foodsec,4,'we frequently do not eat enough')
else
	null
end as 'Household_food situation in the last 12_months'

into Peru_Table
from peru_dataset;


--Creating Schema for Child Monitor
CREATE SCHEMA Child_Monitor;


--Creating Master Table for both India and Peru Transformed Data
SELECT *
INTO Child_Monitor.Master_Table
FROM (SELECT * FROM India_Table UNION ALL
 SELECT * FROM Peru_Table) AS [Master];


-- 5 Analysis Tables

--CREATE TABLE Child_Monitor.Cultural_Info
USE Olawoyin_Coursework;  
GO
CREATE TABLE Child_Monitor.Cultural_Info(
[Child ID]	nvarchar(255) NOT NULL,
[Community_ID] nvarchar(255) NULL,
[Sentinel_site ID] float NULL,
[Region] varchar(255) NULL,
[Area of Residence]	varchar(5) NULL,
[Child_language] nvarchar(255) NULL,
[Ethnic_group] varchar(255) NULL,
[Child_Religion] varchar(255) NULL,
[Ever Married/Cohabited] varchar(5) NULL, 
[Has a Child] varchar(5) NULL);
--Populating the Cultural_Info Table 
INSERT INTO Child_Monitor.Cultural_Info
SELECT [Child ID], 
[Community_ID], 
[Sentinel_site ID], 
[Region], 
[Area of Residence],
[Child_language], 
[Ethnic_group], 
[Child_Religion], 
[Ever Married/Cohabited], 
[Has a Child]
FROM Child_Monitor.Master_Table
WHERE [Round of survey] = 1;
GO


--CREATE TABLE Child_Monitor.Child_Health
USE Olawoyin_Coursework;  
GO
CREATE TABLE Child_Monitor.Health(
[Child ID] nvarchar(255) NOT NULL,
[Round of survey] float NULL,
[Interview_Date] date NULL,
[Sex] nvarchar(30) NULL,
[Calculated_BMI] float NULL,
[Longterm_health_problem] varchar(3) NULL,
[Permanent_Disability] varchar(3) NULL,
[Health_state] nvarchar(255) NULL,
[Health compared with peers] varchar(255) NULL,
[9-step ladder] nvarchar(255) NULL,
[Deceased] varchar(3) NULL);
--Populating the Health Table
INSERT INTO Child_Monitor.Health
SELECT [Child ID],
[Round of survey],
Interview_Date,
Sex,
Calculated_BMI,
Longterm_health_problem,
Permanent_Disability,
Health_state,
[Health compared with peers],
[9-step ladder],
Deceased
FROM child_monitor.Master_Table;
GO


--CREATE TABLE Child_Monitor.Education
USE Olawoyin_Coursework;  
GO
CREATE TABLE Child_Monitor.Education(
[Child ID] nvarchar(255) NOT NULL,
[Round of survey] float NULL,
[Pre-primary school] varchar(3) NULL,
[Travel_time to school(min)] float NULL,
[Age @ starting of grade1] float NULL,
[currently_enrolled] varchar(255) NULL,
[School_type] varchar(255) NULL,
[Current_grade] varchar(255) NULL,
[Reading_level] nvarchar(255) NULL,
[Writing_level] nvarchar(255) NULL,
[Literate] varchar(3) NULL);
--Populating the Education Table
INSERT INTO Child_Monitor.Education
SELECT [Child ID],
[Round of survey],
[Pre-primary school],
[Travel_time to school(min)],
[Age @ starting of grade1],
currently_enrolled,
School_type,
Current_grade,
Reading_level,
Writing_level,
Literate
FROM Child_Monitor.Master_Table;
GO  


--CREATE TABLE for Child_Monitor.Family
USE Olawoyin_Coursework;  
GO
CREATE TABLE Child_Monitor.Family(
[Child ID] nvarchar(255) NOT NULL,
[Round of survey] float NULL,
[Interview_Date] date NULL,
[Area of Residence] varchar(5) NULL,
[Curently_living_Household] varchar(3) NULL,
[Caregiver education_level] varchar(255) NULL,
[Caregiver relatioinship household_Head] varchar(255) NULL,
[Caregiver Age] float NULL,
[Caregiver Sex] varchar(6) NULL,
[Caregiver-child relationship] varchar(255) NULL,
[Caregiver 9-Step Ladder] float NULL,
[Dad education_level] varchar(255) NULL,
[Location of Father] varchar(255) NULL,
[Father Age] float NULL,
[Father Literate] varchar(3) NULL,
[Father Death] nvarchar(255) NULL,
[Mother education_level] varchar(255) NULL,
[Location of Mother] varchar(255) NULL,
[Mother Age] float NULL,
[Mother Literate] varchar(3) NULL,
[Mother Death] nvarchar(255) NULL,
[Household_head education] varchar(255) NULL,
[Household_head Age] float NULL,
[Household_head Sex] varchar(6) NULL,
[Household_head Child_Relationship] varchar(255) NULL,
[Household Size] float NULL,
[Male_Kids in Household] float NULL,
[Male_Adults in Household] float NULL,
[Female_Kids in Household] float NULL,
[Female_Adults in Household] float NULL);
--Populating the Family Table
INSERT INTO Child_Monitor.Family
SELECT [Child ID],
[Round of survey],
Interview_Date,
[Area of Residence],
Curently_living_Household,
[Caregiver education_level],
[Caregiver relationship household_Head],
[Caregiver Age],
[Caregiver Sex],
[Caregiver-child relationship],
[Caregiver 9-Step Ladder],
[Dad education_level],
[Location of Father],
[Father Age],
[Father Literate],
[Father Death],
[Mother education_level],
[Location of Mother],
[Mother Age],
[Mother Literate],
[Mother Death],
[Household_head education],
[Household_head Age],
[Household_head Sex],
[Household_head Child_Relationship],
[Household Size],
[Male_Kids in Household],
[Male_Adults in Household],
[Female_Kids in Household],
[Female_Adults in Household]
FROM child_monitor.Master_Table;
GO


--CREATE TABLE Child_Monitor.Lifestyle
USE Olawoyin_Coursework;  
GO
CREATE TABLE Child_Monitor.Lifestyle(
[Child ID] nvarchar(255) NOT NULL,
[Round of survey] float NULL,
[Sleeping] float NULL,
[Curently_living_Household] varchar(3) NULL,
[School] float NULL,
[Rate_of_Smoking] nvarchar(255) NULL,
[Work commute_to&fro(mins)] nvarchar(255) NULL,
[Alcohol_use_1/week] varchar(3) NULL,
[Electricity_Access] varchar(3) NULL,
[Caring for family] float NULL,
[Chores] float NULL,
[Access to Services_Index] float NULL,
[Household_owned_livestock] varchar(3) NULL,
[Tasks] float NULL,
[Work] float NULL,
[Studying] float NULL,
[Playing] float NULL,
[School commute_to&fro(mins)] nvarchar(255) NULL,
[Wealth_Index] float NULL,
[Housing Quality_Index] float NULL,
[Consumer Durables_Index] float NULL,
[Safe Drinking Water_Access] varchar(3) NULL,
[Household_owned_land] varchar(3) NULL,
[Household_owned_house] varchar(3) NULL,
[Losses due to crime] varchar(3) NULL,
[Household got loan(12months)] varchar(3) NULL,
[Household_food situation in the last 12_months] nvarchar(255) NULL);
--Populating the Lifestyle Table
INSERT INTO Child_Monitor.Lifestyle
SELECT [Child ID],
[Round of survey],
Sleeping,
Curently_living_Household,
School,
Rate_of_Smoking,
[Work commute_to&fro(mins)],
[Alcohol_use_1/week],
Electricity_Access,
[Caring for family],
Chores,
[Access to Services_Index],
Household_owned_livestock,
Tasks,
[Work],
Studying,
Playing,
[School commute_to&fro(mins)],
Wealth_Index,
[Housing Quality_Index],
[Consumer Durables_Index],
[Safe Drinking Water_Access],
Household_owned_land,
Household_owned_house,
[Losses due to crime],
[Household got loan(12months)],
[Household_food situation in the last 12_months]
FROM child_monitor.Master_Table;
GO

--KEYS
ALTER TABLE Child_monitor.Cultural_Info
	ALTER COLUMN [child id] nvarchar(255) NOT NULL;

ALTER TABLE Child_monitor.Cultural_Info
ADD CONSTRAINT PK_Cuar PRIMARY KEY ([child id]);

ALTER TABLE Child_monitor.Lifestyle 
ADD CONSTRAINT FK_lif
FOREIGN KEY ([child id]) REFERENCES Child_monitor.Cultural_Info([child id]);

ALTER TABLE Child_monitor.Education 
ADD CONSTRAINT FK_Edu
FOREIGN KEY ([child id]) REFERENCES Child_monitor.Cultural_Info([child id]);

ALTER TABLE Child_monitor.Family 
ADD CONSTRAINT FK_Fam
FOREIGN KEY ([child id]) REFERENCES Child_monitor.Cultural_Info([child id]);

ALTER TABLE Child_monitor.Health
ADD CONSTRAINT FK_Hea
FOREIGN KEY ([child id]) REFERENCES Child_monitor.Cultural_Info([child id]);


--VIEWS
--A view showing deceased children details during the survey
CREATE VIEW Child_Monitor.Deceased_Info
AS
SELECT [Child ID], sex, Longterm_health_problem, Permanent_Disability, Deceased
FROM Child_Monitor.Health
WHERE deceased = 'yes' 
AND [Round of survey] = 5;

--A view showing Total female deceased children
CREATE VIEW Child_Monitor.Total_female_deceased
AS
SELECT COUNT(*) AS Total_female_deceased
FROM Child_Monitor.Deceased_Info --created view
WHERE SEX = 'female';

--A view showing Total male deceased children
CREATE VIEW Child_Monitor.Total_male_deceased 
AS
SELECT COUNT(*) AS Total_male_deceased
FROM Child_Monitor.Deceased_Info --created view
WHERE SEX = 'Male';

--A view showing child, parents, household_head and caregiver education information
CREATE VIEW Child_Monitor.All_Education_Info 
AS
SELECT [Child ID], [Literate], [School], [Dad education_level], [Mother education_level], [Father Literate], [Mother Literate], [Caregiver education_level], [Household_head education]
FROM Child_Monitor.Master_Table
WHERE [Round of survey] = 5;

--A view showing basic social amenities availability
CREATE VIEW Child_Monitor.Social_Amenities
AS
SELECT [Child ID], [Area of Residence], [Region], [Electricity_Access], [Safe Drinking Water_Access]
FROM Child_Monitor.Master_Table
WHERE [Round of survey] = 5;

--A view showing all Major Caculated Index
CREATE VIEW Child_Monitor.Caculated_Index
AS
SELECT [Child ID], [Access to Services_Index], [Wealth_Index], [Housing Quality_Index], [Consumer Durables_Index]
FROM Child_Monitor.Master_Table
WHERE [Round of survey] = 5;

--FUNCTIONS
--A Scalar function that displays the BMI and Child Information
CREATE FUNCTION [Child_Monitor].[Child_Info_BMI_PerRound] (@childid nvarchar(15), @round int)
returns nvarchar (222)
as
begin
return( SELECT ([Child ID]+ ' is a child that lives in '+iif(left([child id],2)='IN','India','Peru')
+'and belong to the ethnic group of '+[Ethnic_Group]+' in '+[Area of Residence]+' '+Region+'. '+
iif([Sex]='male','He','She')+' has a Calculated BMI of' + cast([Calculated_BMI] as nvarchar(50)))
FROM Child_Monitor.Master_Table
where [Round of survey] = @round
and [Child ID]= @childid)
end;

-- A function for Number of children for each caculated_bmi per selected round
CREATE FUNCTION [Child_monitor].[calc_bmi]
(@round FLOAT)
RETURNS table
AS 
RETURN (SELECT [Calculated_BMI], count([child ID]) 'Children'
FROM [Child_monitor].Health
WHERE [Round of survey] = @round
GROUP BY [Calculated_BMI])

--Stored Procedure
--A stored procedure to detect child sexual abuse for each round
CREATE PROCEDURE Child_Monitor.child_abuse_detector
	@roundOfSurvey int,
	@sex nvarchar(5)
AS
	SET NOCOUNT ON;
	SELECT [Child ID], [Round of survey], [Sex], [5 reproductive health_questions], [Ever Married/Cohabited], [Has a Child], [Age at Offspring Birth],[Curently_living_Household],[Caregiver Sex], [Caregiver-child relationship],[Location of Father],[Location of Mother]
	FROM Child_Monitor.Master_Table
	WHERE [Round of survey] = @roundOfSurvey AND [Sex] = @sex
GO

EXECUTE Child_Monitor.child_abuse_detector 2, N'male';


--TRIGGER
--Creating a Trigger that does not allow deletion of row from the Primary Key Table
CREATE TRIGGER child_monitor.DeleteNotAllowed
ON child_monitor.Cultural_Info
INSTEAD OF DELETE
AS
IF EXISTS (SELECT * FROM child_monitor.Cultural_Info)
DECLARE @Error nvarchar(111)
SELECT	@Error = 'Error! This table contains a primary key'
BEGIN
RAISERROR( @Error, 16, 1 )
ROLLBACK TRANSACTION
END;
GO
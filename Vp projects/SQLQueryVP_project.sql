create table Rooms(
R_ID int not null identity(1,1) primary key,
RoomName nvarchar(max),
ID int not null,
FOREIGN KEY (ID) REFERENCES Projects(ID),


);

create table Projects(
ID int not null identity(1,1) primary key,
Q_ID int not null,
FOREIGN KEY (Q_ID) REFERENCES Quotation(Q_ID),
Project_Title nvarchar(max),
Project_Description nvarchar(max),
Statuses nvarchar(max),
StartDate nvarchar(max),
CompletionDate nvarchar(max),

);

create Table Quotation(
Q_id int not null identity(1,1) primary key,
ID int FOREIGN KEY REFERENCES Clients(ID),
PreTaxSaleAmount nvarchar(max),
Discount nvarchar(max),
Basic_ nvarchar(max),
Classic nvarchar(max),
Luxury nvarchar(max),
preparationDate nvarchar(max),
Expirydate nvarchar(max)
);

create Table Clients(
ID int not null identity(1,1) primary key,
NameFirst  nvarchar(max),
NameLast nvarchar(max),
StreetAddress nvarchar(max),
City nvarchar(max),
Province nvarchar(max),
Country nvarchar(max),
Phone nvarchar(max),
Email nvarchar(max),

);


create Table Materials(
M_ID int not null identity(1,1) primary key,
ProductsDescription  nvarchar(max),
MaterialName nvarchar(max),
Quantity nvarchar(max),
CoverageArea nvarchar(max),
Width nvarchar(max),
Lengths nvarchar(max),
Height nvarchar(max),
E_ID int Foreign Key References Element(E_ID),


);

Create Table Element(
E_ID int not null identity(1,1) primary key,
ElementsName Nvarchar(max),
ElementsTag nvarchar(max),


);

create Table ClientsAppointment(
CA_ID int not null identity(1,1) primary key,
AppointmentDate  nvarchar(max),
AppointmentTime nvarchar(max),
AppointmentDuration nvarchar(max),
AppointmentLocation nvarchar(max),
ID int Foreign Key References Clients(ID)


);

create Table Employee(
Emp_ID int not null identity(1,1) primary key,
NameFirst  nvarchar(max),
NameLast nvarchar(max),
Designation nvarchar(max),
Gender nvarchar(max),
HiredDate nvarchar(max),
TerminationDate nvarchar(max),
IsActive nvarchar(max),
StreetAddress nvarchar(max),
City nvarchar(max),
Province nvarchar(max),
Country nvarchar(max),
Phone nvarchar(max),
Email nvarchar(max),

);

ALTER TABLE Quotation
Add M_ID int Foreign Key References Materials(M_ID)
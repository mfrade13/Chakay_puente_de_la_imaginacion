module(..., package.seeall)

local _W = display.contentWidth
local _H = display.contentHeight
local sqlite3 = require ("sqlite3")

--- coding convention ---
-- use Upper_Snake_Case for values in sqlite3, fields in english
-- table names are lower case
-- use lowerCamelCase for lua variables

--Path to store the db file
local pathsql="chackayDB.sqlite"
local path = system.pathForFile(pathsql, system.DocumentsDirectory)

local usuario = "usuario"
local currentUser = "currentUser"
local puntajes = "puntajes"
local progreso = "progreso"
local lenguaje = "lenguaje"

function createDatabase( )
	--Open the DB to create tables
	 db = sqlite3.open( path ) 
	 -- creacion de tablas
	 local query1 = "create table if not exists " .. usuario.." ( ID_Usuario integer PRIMARY KEY AUTOINCREMENT, User_Name VARCHAR(30) not null, Correo VARCHAR(25)  );"
	 local query2 = "create table if not exists " .. puntajes.."(ID_Puntaje int PRIMARY key AUTOINCREMENT, ID_Usuario integer, Score integer(10), foreign key ('ID_Usuario') references usuario('ID_Usuario')   );"
	 local query3 = "create table if not exists " .. progreso .. "(ID_Progreso integer PRIMARY KEY AUTOINCREMENT, ID_Usuario integer, Scene VARCHAR(20), foreign key ('ID_Usuario') references usuario('ID_Usuario')  );" 
	 local query4 = "create table if not exists " .. lenguaje.." (IDLanguage int PRIMARY KEY , language VARCHAR(15),defined integer(2) );"
	 local query5 = "create table if not exists " .. currentUser.." ( ID_Usuario integer   );"

	 -- modificacion de tablas

	 -- datos para insertar


	 --inserciones de tablas
	 db:execute(query1)
	 db:execute(query2)
	 db:execute(query3)
	 db:execute(query4)
	 --inserciones de datos




	 db:close()
end

	createDatabase()

function guardarResultados( params )
	db:sqlite3.open()
	local sql = "insert into " .. progreso .. " "
	if params then
		sql = sql .. "("
	end
	local length = #params
	for i=1, length, 1 do
		if params.scene ~= nil then
			sql = sql .. " Scene"
		end

		if params.level ~= nil then
			sql = sql .. " Level"
		end
		if i ~= length do 
			sql = sql .. ", "
		end
	end
	if params then
		sql = sql .. ")"
	end

	sql = sql .. " values("
	for i=1, length, 1 do
		if params.scene ~= nil then
			sql = sql .. "" .. params.scene
		end

		if params.level ~= nil then
			sql = sql .. "" .. params.level
		end
		if i ~= length do 
			sql = sql .. ", "
		end
	end

	sql = sql .. " );"

	db:execute(sql)

	db:close()
end


function obtenerUsuario(  )
	local listausuario ={}
	db:sqlite3.open()
	local k = 1
	local sql = "SELECT * from "..usuario ";"
	for x in db:nrows(sql) do
		listausuario[k]={"ID" =x.ID_Usuario , "userName" ="".. x.User_Name, "correo" = x.Correo}
		k+1
	end
	return listausuario
end

function agregarUsuario( ID, User, Correo)
	db:sqlite3.open()
	local sql = "insert into ".. usuario .. "(ID_Usuario, User_Name, Correo) values (" .. ID .. ", " .. User .. ", " .. correo ..  ");"
	db:execute(sql)
	local sql2 = "insert into " .. resultado .. "(ID_Usuario, Scene) values (".. ID .. ", menu);"
	db:execute(sql2)
	local sql3 = "insert into .. " currentUser .. "(ID_Usuario) values ("..ID ..")"
	db:execute(sql3)

	db:close()
end

function getCurrentUser( )
	db:sqlite3.open()
	local sql = "select * from " .. currentUser .. ";"
	local k = 1
	local result 
	for x in db:nrows(sql) do
		result = x.ID_Usuario
	end 

	db:close()	
	return result
end

function getScene( )
	db:sqlite3.open()
	local userID = getCurrentUser()

	local sql = "select Scene, Level from progreso where userID = " .. userID .. ";"
	local result 
	for x in db:nrows(sql) do
		result = {"Scene" = x.Scene, "Level" = x.Level}
	end 
	db:close()

	return result
end

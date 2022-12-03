CREATE TABLE "public.ORDERS" (
	"order_id" serial NOT NULL,
	"order_date" DATE NOT NULL,
	"status" character varying NOT NULL,
	"cost_for_client" DECIMAL NOT NULL,
	"currency" character varying NOT NULL,
	"manager_id" bigint NOT NULL,
	"client_id" bigint NOT NULL,
	"desc" character varying NOT NULL,
	"delivery_id" bigint NOT NULL,
	CONSTRAINT "ORDERS_pk" PRIMARY KEY ("order_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.PRODUCTS" (
	"product_id" serial NOT NULL,
	"product_name" serial NOT NULL,
	"category_id" bigint NOT NULL,
	"desc" serial NOT NULL,
	"weight" serial,
	"unit" serial,
	"product_code" serial,
	CONSTRAINT "PRODUCTS_pk" PRIMARY KEY ("product_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.CATEGORIES" (
	"category_id" bigint NOT NULL,
	"parent_id" bigint NOT NULL,
	"desc" character varying NOT NULL,
	CONSTRAINT "CATEGORIES_pk" PRIMARY KEY ("category_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.ORDERS_PRODUCTS" (
	"id" serial NOT NULL,
	"order_id" bigint NOT NULL,
	"product_id" bigint NOT NULL,
	CONSTRAINT "ORDERS_PRODUCTS_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.SHIPPERS" (
	"shipper_id" serial NOT NULL,
	"shipper_name" character varying NOT NULL,
	"inn" character varying NOT NULL,
	"address" character varying NOT NULL,
	"phone" character varying NOT NULL,
	"is_active" BOOLEAN NOT NULL,
	CONSTRAINT "SHIPPERS_pk" PRIMARY KEY ("shipper_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.SUPPLIES" (
	"supply_id" serial NOT NULL,
	"product_id" bigint NOT NULL,
	"product_cost" DECIMAL NOT NULL,
	CONSTRAINT "SUPPLIES_pk" PRIMARY KEY ("supply_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.SHIPPERS_SUPPLIES" (
	"id" serial NOT NULL,
	"shipper_id" bigint NOT NULL,
	"supply_id" bigint NOT NULL,
	CONSTRAINT "SHIPPERS_SUPPLIES_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.MANAGERS" (
	"manager_id" serial NOT NULL,
	"manager_name" character varying NOT NULL,
	"position" character varying NOT NULL,
	"contacts" character varying NOT NULL,
	"is_active" BOOLEAN NOT NULL,
	CONSTRAINT "MANAGERS_pk" PRIMARY KEY ("manager_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.CLIENTS" (
	"client_id" serial NOT NULL,
	"client_name" character varying NOT NULL,
	"position" character varying NOT NULL,
	"contacts" character varying NOT NULL,
	"is_active" BOOLEAN NOT NULL,
	CONSTRAINT "CLIENTS_pk" PRIMARY KEY ("client_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "public.DELIVERIES" (
	"delivery_id" serial NOT NULL,
	"delivery_date" DATE NOT NULL,
	"weight" double NOT NULL,
	"cost" DECIMAL NOT NULL,
	"status" character varying NOT NULL,
	"provider" character varying NOT NULL,
	CONSTRAINT "DELIVERIES_pk" PRIMARY KEY ("delivery_id")
) WITH (
  OIDS=FALSE
);

ALTER TABLE "ORDERS" ADD CONSTRAINT "ORDERS_fk0" FOREIGN KEY ("order_id") REFERENCES "ORDERS_PRODUCTS"("order_id");

ALTER TABLE "PRODUCTS" ADD CONSTRAINT "PRODUCTS_fk0" FOREIGN KEY ("product_id") REFERENCES "ORDERS_PRODUCTS"("product_id");

ALTER TABLE "CATEGORIES" ADD CONSTRAINT "CATEGORIES_fk0" FOREIGN KEY ("category_id") REFERENCES "PRODUCTS"("category_id");

ALTER TABLE "SHIPPERS" ADD CONSTRAINT "SHIPPERS_fk0" FOREIGN KEY ("shipper_id") REFERENCES "SHIPPERS_SUPPLIES"("shipper_id");

ALTER TABLE "SUPPLIES" ADD CONSTRAINT "SUPPLIES_fk0" FOREIGN KEY ("product_id") REFERENCES "PRODUCTS"("product_id");

ALTER TABLE "SHIPPERS_SUPPLIES" ADD CONSTRAINT "SHIPPERS_SUPPLIES_fk0" FOREIGN KEY ("shipper_id") REFERENCES "DELIVERIES"("shipper_id");

ALTER TABLE "SHIPPERS_SUPPLIES" ADD CONSTRAINT "SHIPPERS_SUPPLIES_fk1" FOREIGN KEY ("supply_id") REFERENCES "SUPPLIES"("supply_id");

ALTER TABLE "MANAGERS" ADD CONSTRAINT "MANAGERS_fk0" FOREIGN KEY ("manager_id") REFERENCES "ORDERS"("manager_id");

ALTER TABLE "CLIENTS" ADD CONSTRAINT "CLIENTS_fk0" FOREIGN KEY ("client_id") REFERENCES "ORDERS"("client_id");

ALTER TABLE "DELIVERIES" ADD CONSTRAINT "DELIVERIES_fk0" FOREIGN KEY ("delivery_id") REFERENCES "ORDERS"("delivery_id");

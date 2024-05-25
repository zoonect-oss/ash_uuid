defmodule AshUUID.PostgresExtension do
  @moduledoc false

  use AshPostgres.CustomExtension, name: "ash-uuid", latest_version: 1

  @impl true
  def install(0) do
    """
    execute(\"\"\"
    CREATE OR REPLACE FUNCTION uuid_generate_v7()
    RETURNS uuid
    AS $$
    DECLARE
      unix_ts_ms BYTEA;
      uuid_bytes BYTEA;
    BEGIN
      unix_ts_ms = substring(int8send(floor(extract(epoch FROM clock_timestamp()) * 1000)::BIGINT) FROM 3);
      uuid_bytes = uuid_send(gen_random_uuid());
      uuid_bytes = overlay(uuid_bytes placing unix_ts_ms FROM 1 FOR 6);
      uuid_bytes = set_byte(uuid_bytes, 6, (b'0111' || get_byte(uuid_bytes, 6)::BIT(4))::BIT(8)::INT);
      RETURN encode(uuid_bytes, 'hex')::UUID;
    END
    $$
    LANGUAGE PLPGSQL
    VOLATILE;
    \"\"\")
    """
  end

  @impl true
  def uninstall(_version) do
    """
    # execute(\"DROP FUNCTION IF EXISTS uuid_generate_v7()\")
    """
  end
end

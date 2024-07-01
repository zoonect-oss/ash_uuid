defmodule AshUUID.PostgresExtension do
  @moduledoc false

  use AshPostgres.CustomExtension, name: "ash-uuid", latest_version: 2

  @impl true
  def install(_v) do
    """
    execute(\"\"\"
    CREATE OR REPLACE FUNCTION uuid_generate_v7()
    RETURNS UUID
    AS $$
    DECLARE
      timestamp    TIMESTAMPTZ;
      microseconds INT;
    BEGIN
      timestamp    = clock_timestamp();
      microseconds = (cast(extract(microseconds FROM timestamp)::INT - (floor(extract(milliseconds FROM timestamp))::INT * 1000) AS DOUBLE PRECISION) * 4.096)::INT;

      RETURN encode(
        set_byte(
          set_byte(
            overlay(uuid_send(gen_random_uuid()) placing substring(int8send(floor(extract(epoch FROM timestamp) * 1000)::BIGINT) FROM 3) FROM 1 FOR 6
          ),
          6, (b'0111' || (microseconds >> 8)::bit(4))::bit(8)::int
        ),
        7, microseconds::bit(8)::int
      ),
      'hex')::UUID;
    END
    $$
    LANGUAGE PLPGSQL
    VOLATILE;
    \"\"\")

    execute(\"\"\"
    CREATE OR REPLACE FUNCTION timestamp_from_uuid_v7(_uuid uuid)
    RETURNS TIMESTAMP WITHOUT TIME ZONE
    AS $$
      SELECT to_timestamp(('x0000' || substr(_uuid::TEXT, 1, 8) || substr(_uuid::TEXT, 10, 4))::BIT(64)::BIGINT::NUMERIC / 1000);
    $$
    LANGUAGE SQL
    IMMUTABLE PARALLEL SAFE STRICT LEAKPROOF;
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

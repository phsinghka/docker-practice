
**Steps to Build and Run:**

1. **Build the Docker Image:**
   ```bash
   docker build -t entrypoint-cmd-demo .
   ```

2. **Run the Docker Container:**
   ```bash
   docker run --rm entrypoint-cmd-demo
   ```
   Output:
   ```
   MY_VAR is set to: default_value
   Running command: default_command
   ```

3. **Override CMD at Runtime:**
   ```bash
   docker run --rm entrypoint-cmd-demo /bin/sh -c "echo Hello World"
   ```
   Output:
   ```
   MY_VAR is set to: default_value
   Running command: /bin/sh -c echo Hello World
   Hello World
   ```


- **ENTRYPOINT**: Sets the main command that will always be executed when the container starts. In this example, `/entrypoint.sh` is set as the `ENTRYPOINT`, so it will run whenever the container is started.

- **CMD**: Provides default arguments to the `ENTRYPOINT` command. If no arguments are supplied at runtime, the `CMD` value will be used. In this example, `default_command` is the default command passed to `ENTRYPOINT`.


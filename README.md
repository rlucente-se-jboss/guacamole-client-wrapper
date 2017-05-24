# Guacamole Client Wrapper
This is a thin wrapper around the [Apache Guacamole](https://github.com/glyptodon/guacamole-client)
docker image to enable it to run unprivileged in OpenShift and with a stable `GUACAMOLE_HOME` path.

The following changes were made to the start.sh script:

    --- a/start.sh    2017-05-24 10:54:44.000000000 -0400
    +++ b/start.sh    2017-05-24 11:03:27.000000000 -0400
    @@ -28,9 +28,9 @@
     ## script, running in the foreground until terminated.
     ##
    
    -GUACAMOLE_HOME_TEMPLATE="$GUACAMOLE_HOME"
    +umask 0002
    
    -GUACAMOLE_HOME="$HOME/.guacamole"
    +GUACAMOLE_HOME="/home/guacamole/.guacamole"
     GUACAMOLE_EXT="$GUACAMOLE_HOME/extensions"
     GUACAMOLE_LIB="$GUACAMOLE_HOME/lib"
     GUACAMOLE_PROPERTIES="$GUACAMOLE_HOME/guacamole.properties"
    @@ -344,14 +344,6 @@
     rm -Rf "$GUACAMOLE_HOME"
    
     #
    -# Copy contents of provided GUACAMOLE_HOME template, if any
    -#
    -
    -if [ -n "$GUACAMOLE_HOME_TEMPLATE" ]; then
    -    cp -a "$GUACAMOLE_HOME_TEMPLATE/." "$GUACAMOLE_HOME/"
    -fi
    -
    -#
     # Create and define Guacamole lib and extensions directories
     #


Files used to build the docker image at https://hub.docker.com/r/dting/jupyter/

This is a combination of:

- https://github.com/mfellner/javascript-notebook
- https://github.com/srhopkins/jupyter

To use the docker image you can download the `start_notebook.sh` and run it:

    ./start_notebook.sh

or use the command inside directly:

    docker run --rm -p 8888:8888 --name jupyter -v ${2:-$PWD}/notebooks:/notebooks dting/jupyter:latest

which will create a `notebooks/` directory in the current directory where the notebook files will be saved.

## Notes for OSX

To find the ip where the notebook is accessible use:

    docker-machine ip

Then navigate to `<docker-machine ip>:8888` in your browser.

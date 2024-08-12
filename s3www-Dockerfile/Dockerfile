# Start with the official Alpine base image
FROM golang:1.22

# Set up Go environment
ENV GOPATH=$HOME/gocode
ENV GO111MODULE=on
ENV PATH="$GOPATH/bin:/usr/local/go/bin:${PATH}"

# Fetch and install the s3www package
RUN go install github.com/harshavardhana/s3www@latest

# Set the command to start bash by default
CMD ["bash"]




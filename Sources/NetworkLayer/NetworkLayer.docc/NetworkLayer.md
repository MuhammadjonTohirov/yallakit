# ``NetworkLayer``

Lightweight, type-safe networking engine built on URLSession for HTTP operations, parsing, and error handling.

## Overview

NetworkLayer provides the infrastructure for all network communication in YallaKit. It uses protocol-oriented design with ``URLRequestProtocol`` for defining endpoints, ``NetworkClientProtocol`` for sending requests, and ``NetRes`` for type-safe response handling.

## Topics

### Core Protocols

- ``URLRequestProtocol`` — Contract for creating HTTP requests (url, body, method)
- ``NetworkClientProtocol`` — Abstraction for sending requests (send, sendThrow, upload)
- ``NetResBody`` — Base protocol for all response body types

### Implementations

- ``DefaultNetworkClient`` — Default implementation of NetworkClientProtocol
- ``HTTPMethod`` — Supported HTTP methods (GET, POST, PUT, DELETE)

### Response Handling

- ``NetRes`` — Generic response wrapper with success, result, message, code, error

### Configuration

- ``NetworkDelegate`` — Handles auth failures (onAuthRequired) and network errors (onFailureNetwork)

### File Upload

- ``MultipartForm`` — Multipart form data builder for file uploads

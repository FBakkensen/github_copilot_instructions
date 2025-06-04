---
applyTo: '**/*.al'
---
# Business Central Integration Standards

This document outlines best practices for integrating with Business Central and ensuring a consistent user experience.

## User Experience Integration

1. Respect the standard Business Central user experience patterns
2. Use standard controls and UI patterns
3. Follow the Business Central action patterns
4. Implement proper field validation
5. Apply personalization capabilities where appropriate
6. Consider multi-language support
7. Implement proper dimension support
8. Follow Business Central API design principles

## Event-Based Integration

1. Use event publishers and subscribers for loose coupling between modules
2. Implement proper event handling with clear documentation
3. Follow the standard event naming conventions:
   - OnBefore[Action]
   - OnAfter[Action]
   - On[Action]
4. Use business events for integration points that may be consumed by other extensions

## API Integration

1. Follow RESTful API design principles
2. Implement proper authentication and authorization
3. Use standard Business Central API endpoints when available
4. Document all API endpoints thoroughly
5. Implement proper error handling and status codes
6. Consider rate limiting and throttling for high-volume integrations
7. Use OData standards for query parameters and filtering

## External System Integration

1. Use proper authentication mechanisms for external systems
2. Implement retry logic for external API calls
3. Handle timeouts and connection issues gracefully
4. Log all integration activities for troubleshooting
5. Implement proper error handling for external system failures
6. Consider using queues for asynchronous processing
7. Implement proper data validation before sending to external systems

## Integration Security

1. Never store credentials in code or configuration files
2. Use OAuth or other secure authentication methods
3. Implement proper error handling that doesn't expose sensitive information
4. Validate all input from external systems
5. Implement proper logging for security events
6. Follow the principle of least privilege for integration accounts
7. Regularly review and update integration security measures

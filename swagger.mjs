import swaggerJsdoc from 'swagger-jsdoc';
import fs from 'fs';

const options = {
  definition: {
    openapi: '3.1.0',
    info: {
      title: 'Open Sustainability Index API',
      version: '1.0.0',
    },
    servers: [{ url: 'https://api.opensustainabilityindex.org/' }],
  },
  apis: ['./app/routes/*.tsx'],
};

const openapiSpecification = await swaggerJsdoc(options);

fs.writeFileSync('./public/openapi.json', JSON.stringify(openapiSpecification, null, 2));



'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
      await queryInterface.bulkInsert('Cars', [
      {
        carName: 'Jaguar XE',
        brandName: 'Jaguar',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        carName: 'Audi R8',
        brandName: 'Audi',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        carName: 'Tata Safari XT+',
        brandName: 'Tata',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        carName: 'Ferrari Portofino',
        brandName: 'Ferrari',
        createdAt: new Date(),
        updatedAt: new Date()
      }
   
    ], {});
    
  },

  async down (queryInterface, Sequelize) {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};

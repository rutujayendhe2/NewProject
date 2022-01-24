'use strict';

module.exports = {
  async up (queryInterface, Sequelize) 
  {
    await queryInterface.bulkInsert('Heros',
    [
      {
        heroName: 'Amitabh Bacchan',
        filmName: 'Shole',
        createdAt: new Date(),
        updatedAt: new Date()

      },

      {
        heroName: 'Aamir Khan',
        filmName: 'Dangal',
        createdAt: new Date(),
        updatedAt: new Date()

      },
      {
        heroName: 'Salman Khan',
        filmName: 'Kick',
        createdAt: new Date(),
        updatedAt: new Date()

      },
    
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

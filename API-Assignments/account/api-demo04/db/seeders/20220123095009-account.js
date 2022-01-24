'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Accounts', [
      {
        accno: 837975353,
        accnamr: 'Gayatri',
        balance: 13000,
        createdAt: new Date(),
        updatedAt: new Date()
      },

      {
        accno: 837975453,
        accnamr: 'Ankit',
        balance: 46000,
        createdAt: new Date(),
        updatedAt: new Date()
      },

      {
        accno: 837971237,
        accnamr: 'Rutuja',
        balance: 43000,
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

'use strict';

module.exports = {
  async up (queryInterface, Sequelize) 
  {
    await queryInterface.bulkInsert('Authors', [
      {
      authorName: 'Bimal Jalan',
      bookName: 'The India Story',
      createdAt: new Date(),
      updatedAt: new Date()

      },
      {
        authorName: 'K.Ramakrishna Rao',
        bookName: 'A Child of Destiny',
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

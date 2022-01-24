'use strict';

module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Books', [
      {
        bookName: 'The India Story',
        authorName: 'Bimal Jalan',
        publicationDate: "01-02-2021",
        createdAt: new Date(),
        updatedAt: new Date()
     },
     {
      bookName: 'A Child of Destiny ',
      authorName: 'K.Ramakrishna Rao ',
      publicationDate: "01-02-2022",
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

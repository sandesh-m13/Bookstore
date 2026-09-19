const cds = require('@sap/cds')
const { Books } = require('#cds-models/BookStoreService')

module.exports = class BookStoreService extends cds.ApplicationService {
  init() {

    this.before('READ', Books, async (req) => {
      console.log('Before READ Books')
    })
    this.after('READ', Books, async (books, req) => {
      for(const book of books){
        if(book.genre_code === 'Fiction'){
          Math.round(book.price *= 0.8, 2);
          book.title = book.title + "(20% Discount)"
        }
      }
      console.log('After READ Books')
    })

    return super.init()
  }
}

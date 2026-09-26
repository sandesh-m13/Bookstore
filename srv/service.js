import { Genre } from '#cds-models/tutorial/db'
import cds from '@sap/cds'
import { Books } from '#cds-models/BookStoreService'
import { Authors } from '#cds-models/BookStoreService'

export default class BookStoreService extends cds.ApplicationService {
  init() {

    this.on('addDiscount', async () => {
      await UPDATE(Books).set({ price: { func: 'ROUND', args: [{ xpr: [{ ref: ['price'] }, '*', { val: 0.9 }] }, { val: 2 }] } })
    })

    this.on('addStock', Books, async (req) => {
      const bookId = req.params[0].ID;
      await UPDATE(Books)
        .set({ stock: { '+=': 1 } })
        .where({ ID: bookId })
    })

    this.on('changePublishDate', Books, async (req) => {
      const bookId = req.params[0].ID
      const newDate = req.data.newDate

      await UPDATE(Books)
        .set({ publishedAt: newDate })
        .where({ ID: bookId })
    })

    this.on('changeStatus', Books, async (req) => {
      const bookId = req.params[0].ID
      const newStatus = req.data.newStatus
      await UPDATE(Books)
        .set({ status_code: newStatus })
        .where({ ID: bookId })
    })

    this.before('READ', Books, async (req) => {
    })
    this.after('READ', Books, async (books, req) => {
      for (const book of books) {
        if (book.genre_code === Genre.Fiction) {
          Math.round(book.price *= 0.8, 2);
          book.title = book.title + "(20% Discount)"
        }
      }
    })

    this.after('READ', Authors, async (data) => { //data is just keyword we can use anything
      const ids = data.map(obj => obj.ID)
      const authorIdAndBookCountArray = await SELECT.from(Books)
        .columns('author_ID', { func: 'count' })
        .where({ author_ID: { in: ids } })
        .groupBy('author_ID');
      console.log(authorIdAndBookCountArray)

      for (const obj of data) {
        const authorIdAndBookCountObj = authorIdAndBookCountArray.find(arrayObj => arrayObj.author_ID = obj.ID)
        obj.bookCount = authorIdAndBookCountObj.count
      }

    })

    return super.init()
  }
}
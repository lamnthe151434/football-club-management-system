# import-export-products-management
This project is for managing import & export of a small store

I. Khảo sát hệ thống
1. Câu hỏi phỏng vấn và câu trả lời
- Bác hãy cho biết cửa hàng đang kinh doanh những loại mặt hàng nào?
Thực phẩm, Trà, Tương, Tẩy rửa, Sữa, Mỹ Phẩm, Ngũ Cốc, Nước giải khát, Nước lau nhà, Bánh kẹo, Gia vị, Hóa Mỹ Phẩm, Kem, Đồ chơi, đồ hộp, đồ gia dụng, giày dép, 
- Bác hãy cho biết những thông tin nào của mặt hàng được ghi chép lại?
Mã mặt hàng, tên mặt hàng, nhóm hàng, vị trí, thương hiệu, đơn vị tính, số lượng, giá vốn, giá bán
- Bác hãy cho biết những thông tin nào của hóa đơn(nhập hàng, xuất hàng, đổi trả) được ghi chép lại?
Nhập hàng: Số hóa đơn, ngày tạo đơn, (Tên, địa chỉ, số điện thoại) nhà phân phối, (Tên, địa chỉ, số điện thoại) của chủ cửa hàng, tên mặt hàng, đơn vị tính, số lượng, đơn giá, thành tiền, tổng tiền. 
Đổi trả: Số hóa đơn, ngày tạo đơn, (Tên, địa chỉ, số điện thoại) của chủ cửa hàng, (Tên, địa chỉ, số điện thoại) nhà phân phối, tên mặt hàng, đơn vị tính, số lượng, nhà phân phối, đơn giá, thành tiền, tổng tiền, lý do thu hồi. 
Xuất hàng(Bán hàng): (Tên, địa chỉ, số điện thoại) của chủ cửa hàng, số hóa đơn, ngày tạo đơn, tên khách hàng, tên mặt hàng, đơn vị tính, số lượng, giá bán, thành tiền, tổng tiền 
- Bác hãy cho biết hàng được nhập từ đâu?
Từ nhà phân phối
- Bác hãy cho biết quy trình xử lý hàng đổi trả(do lỗi hoặc hết hạn sử dụng) ra sao?
Tạo hóa đơn đổi trả -> Giao cho người phân phối -> Mang về nơi sản xuất -> Giao cho người phân phối -> Trả hàng đổi trả  
- Làm sao để bác biết cần nhập loại hàng gì, số lượng bao nhiêu? 
Dựa trên doanh thu của mặt hàng đó đem lại trong 1 khoảng thời gian nhất định. (1 tuần, 1 tháng, 1 năm gần đây) 
- Bác lưu lại được lịch sử nhập và xuất hàng hóa bằng cách nào? 
Bác giữ lại hóa đơn nhập hàng, hóa đơn bán hàng bác k lưu lại được.
- Bác có những yêu cầu nào về chức năng của trang web?
Thêm, sửa, xóa, cập nhật sản phẩm.
Thông báo gần hết hoặc hết sản phẩm.
Thống kê doanh thu 1 ngày, 1 tuần, 1 tháng, 1 năm
Thống kê sản phẩm bán chạy, bán chậm
Lưu lại lịch sử nhập, xuất hàng hóa

2. Mô tả nghiệp vụ
- Thông tin hàng hóa gồm: Tên mặt hàng, nhóm hàng, vị trí, thương hiệu, đơn vị tính, số lượng, giá vốn, giá bán
- Thông tin hóa đơn nhập hàng bao gồm: Số hóa đơn, ngày tạo đơn, (Tên, địa chỉ, số điện thoại) nhà phân phối, (Tên, địa chỉ, số điện thoại) của chủ cửa hàng, tên mặt hàng, đơn vị tính, số lượng, đơn giá, thành tiền, tổng tiền. 
- Thông tin hóa đổi trả hàng bao gồm: (Tên, địa chỉ, số điện thoại) của chủ cửa hàng, số hóa đơn, ngày tạo đơn, tên khách hàng, tên mặt hàng, đơn vị tính, số lượng, giá bán, thành tiền, tổng tiền 
- Thông tin hóa bán hàng bao gồm: (Tên, địa chỉ, số điện thoại) của chủ cửa hàng, số hóa đơn, ngày tạo đơn, tên khách hàng, tên mặt hàng, đơn vị tính, số lượng, giá bán, thành tiền, tổng tiền. 
- Thông tin cửa hàng bao gồm: Tên cửa hàng, chủ cửa hàng, địa chỉ, số điện thoại. 
- Thông tin nhà phân phối bao gồm: Tên nhà phân phối, địa chỉ, số điện thoại.
- Thông tin khách hàng bao gồm: Tên khách hàng, địa chỉ, số điện thoại.

- Mỗi mặt hàng có 1 mã mặt hàng để phân biệt với mặt hàng khác.
- Mỗi mặt hàng thuộc về 1 nhóm hàng. 
- Mỗi mặt hàng có thể được giao từ nhiều nhà phân phối.
- Mỗi mặt hàng có thể có từ 2 đơn vị tính trở lên 
- Mỗi nhà phân phối có thể giao nhiều mặt hàng khác nhau. 
- Mỗi khách hàng có thể mua nhiều mặt hàng khác nhau. 
- Chủ cửa hàng có thể thêm, sửa, cập nhật, xóa thông tin hàng hóa hoặc hóa đơn(hóa đơn nhập, xuất)
- Báo cáo doanh thu
- Tìm kiếm hàng hóa có thể bằng tên mã hàng hoặc tên mặt hàng.
- Chủ cửa hàng sẽ kiểm tra hóa đơn nhập hàng trước khi nhận hàng.
- Nếu hàng hóa lỗi hoặc hết hạn thì có thể tạo hóa đơn đổi trả. 
- Nhà phân phối sẽ kiểm tra hóa đơn đổi trả trước khi nhận hàng đổi trả. 
- Nếu hàng được đổi trả thành công thì chủ cửa hàng và nhà phân phối sẽ xác nhận hóa đơn đổi trả thành công. 
- Nếu số lượng mặt hàng trong kho gần hết ( < 100) hoặc hết hàng thì thông báo cho chủ cửa hàng biết. 



II. Các chức năng 
1. Thêm, sửa, xóa, cập nhật thông tin sản phẩm, nhóm sản phẩm, hóa đơn nhập, xuất. 
2. Tra cứu sản phẩm theo tên hoặc mã 
2. Danh sách nhóm sản phẩm
3. Số lượng sản phẩm(còn lại/ đã bán)
4. Thay đổi giá bán của sản phẩm
5. Thông báo sản phẩm sắp hết 
6. Thông báo sản phẩm bán chạy nhất(theo doanh thu + số lượng)
7. Báo cáo doanh thu dựa trên hóa đơn nhập và xuất. 

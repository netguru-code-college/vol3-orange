class ChangeCostColumn < ActiveRecord::Migration[5.2]
  def change
    change_column_default :hotels, :cost, from: nil, to: 0
    change_column_default :transports, :cost, from: nil, to: 0
    change_column_default :attractions, :cost, from: nil, to: 0
  end
end

require "./variant"

module OPC
  @[Flags]
  enum DataValueMask
    HasValue
    HasStatus
    HasSourceTimestamp
    HasServerTimestamp
    HasSourcePicoseconds
    HasServerPicoseconds
  end

  # https://reference.opcfoundation.org/v104/Core/docs/Part6/5.2.2/#5.2.2.17
  class DataValue < BinData
    endian little

    enum_field UInt8, mask : DataValueMask = DataValueMask::HasValue

    custom value : Variant = Variant.new, onlyif: ->{ mask.has_value? }
    uint32 status_code, onlyif: ->{ mask.has_status? }
    uint64 source_timestamp, onlyif: ->{ mask.has_source_timestamp? }
    uint16 source_picoseconds, onlyif: ->{ mask.has_source_picoseconds? }
    uint64 server_timestamp, onlyif: ->{ mask.has_server_timestamp? }
    uint16 server_picoseconds, onlyif: ->{ mask.has_server_picoseconds? }
  end
end
